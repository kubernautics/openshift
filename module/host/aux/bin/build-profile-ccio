#!/bin/bash
#################################################################################
load_vars () {
project_NAME="mini-stack"
base_PATH="/etc/ccio"
full_PATH="${base_PATH}/${project_NAME}"
profile_TARGET="${full_PATH}/profile"

# Check/Create Directory Path
[[ -f ${full_PATH} ]] || mkdir -p ${full_PATH}

# Check/Install whois package for salting the password
[[ $(dpkg -l | grep whois ; echo $?) == 0 ]] || apt install whois -y

clear
}

#################################################################################
prompt_subnet () {
echo "    Please enter a valid /24 subnet:
      EG: 10.10.0.0
      "
read -p '    Subnet: ' input_SUBNET

ministack_SUBNET=$(awk -F'[ .]' '{print $1"."$2"."$3}' <(echo ${input_SUBNET}))

}

#################################################################################
prompt_uname () {
echo "    Is ${provider_UNAME} the same as your primary local username?"
while true; do
read -p '    [Yes/No]: ' stage_NAME
    case ${stage_NAME} in
        [Yy]* ) ministack_UNAME=${provider_UNAME};
                echo "    Setting your project username to: ${ministack_UNAME}";
                break;;
        [Nn]* ) echo "    Please create your project username";
                read -p '    New User: ' ministack_UNAME;
                echo "    Setting your project username to: ${ministack_UNAME}";
                break;;
        *     ) echo "    Please answer 'yes' or 'no'"
                exit;;
    esac
done
}

#################################################################################
prompt_provider_uname () {
echo "    
    Please configure a supported service with your username & ssh public keys
    Supported options:
      GitHub     (enter 'gh')
      Launchpad  (enter 'lp')"
read -p '    gh/lp : ' provider_SSHPUBKEY ;
read -p '    username: ' provider_UNAME
echo ""

prompt_uname
}

#################################################################################
salt_pwd () {
if [[ ${new_pwd} == ${chk_pwd} ]]; then
    ministack_PWDSALT=$(mkpasswd --method=SHA-512 --rounds=4096 ${new_pwd})
elif [[ ${new_pwd} == ${chk_pwd} ]]; then
    prompt_pwd
fi
}

#################################################################################
mk_pwd () {
read -sp '    New Password: ' new_pwd ; echo "" ;
read -sp '    Confirm New PWD: ' chk_pwd
salt_pwd
}

#################################################################################
prompt_pwd () {
echo "
    Please create a user password for this lab environment:
    NOTE: this password will be encrypted in your mini-stack profile
"
mk_pwd
}

#################################################################################
write_profile () {
cat <<EOF > ${profile_TARGET}
# SSH Provider Configuration
export ccio_SSH_SERVICE="${provider_SSHPUBKEY}" # OPTIONS launchpad:lp github:gh
export ccio_SSH_UNAME="${provider_UNAME}"

# Mini Stack User Credentials
export ministack_PWD_SALT="${ministack_PWDSALT}"
export ministack_SUBNET="${ministack_SUBNET}"
export ministack_UNAME="${ministack_UNAME}"

echo '>>>> CCIO Profile Loaded!'
EOF
sed -i "s/\"/\'/g" ${profile_TARGET}
}

#################################################################################
info_print () {
echo "
    CCIO mini-stack profile written to ${profile_TARGET}
    Run the following command to load this profile:
      source ${profile_TARGET}
    "
}

#################################################################################
append_bashrc () {
  # Backup existing .bashrc
  [[ ! -d ~/bak ]] && mkdir ~/bak/
  cp ~/.bashrc ~/bak/.bashrc_$(date +"%s")

  # Build new .bashrc file
  [[ $(grep mini-stack /etc/skel/.bashrc ; echo $?) == 0 ]] \
      || echo "source /etc/ccio/mini-stack/profile" >>/etc/skel/.bashrc
  cp -f /etc/skel/.bashrc ~
}

#################################################################################
req_source_profile () {
echo "    Would you like to load the profile now?"
while true; do
read -p '    [Yes/No]: ' load_PROFILE
    case ${load_PROFILE} in
        [Yy]* ) echo "";
                source ${profile_TARGET};
                break;;
        [Nn]* ) exit;;
        *     ) echo "Please answer 'yes' or 'no'"
    esac
done
}

#################################################################################
run () {
load_vars
prompt_subnet
prompt_provider_uname
prompt_pwd
write_profile
info_print
append_bashrc
req_source_profile
}

#################################################################################
run
