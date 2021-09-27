# Changes linking GitHub and RStudio

From August 13, 2021, GitHub is no longer accepting account passwords when authenticating Git operations. Then when you push a commit and introduce your username and password, you get an error message.

To **solve** this situation you need to add **PAT (Personal Access Token)** instead, you can follow the below method to add PFA on your system

## Create Personal Access Token on Github
From your Github account, go to Settings => Developer Settings => Personal Access Token => Generate New Token (Give your password) => Fillup the form => click Generate token => Copy the generated Token, it will be something like ghp_sFhFsSHhTzMDreGRLjmks4Tzuzgthdvfsrta

Then, when you have to introduce your password, you have to add your PAT.

More information
* [About how to generate PAT](https://stackoverflow.com/questions/68775869/support-for-password-authentication-was-removed-please-use-a-personal-access-to)
* [About the solution](https://stackoverflow.com/questions/68864923/github-password-authentication-was-removed-how-to-connect-git-within-rstudio-to#comment121720804_68864923)

*I hope it will be useful.*