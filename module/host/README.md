# Part 01 -- Host System Setup

## Review checklist of prerequisites:

1. You have a clean install of Fedora Desktop
2. You have no critical or unsaved data on this system
3. You are familiar with and able to ssh between machines
4. You have created an ssh key pair
5. Your Public key is uploaded to a git service such as [Gitlab](https://gitlab.com/) or [Github](https://github.com/)
6. Recommended: Follow these guides using ssh to copy/paste commands as you read along

--------------------------------------------------------------------------------

### 00\. Install Dependencies:

```sh
dnf update  -y
dnf install -y 
```

### 00\. Clone the ocp-mini-stack repo:

```sh
git clone git@github.com:containercraft/ocp-mini-stack.git
```

### 01\. Create CCIO OCP-Mini-Stack Profile
