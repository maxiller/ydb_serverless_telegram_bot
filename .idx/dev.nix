# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.python311
    pkgs.python311Packages.pip
    pkgs.bash-completion
    pkgs.zip

  ];

  # Sets environment variables in the workspace
  env = {
    PATH = ["/home/user/bin"];
    YC_TOKEN = "y0_AgAAAAAABUdNAATuwQAAAAEKsdsEAABDqCcSWiRJaaPlLi577hrQ-4XpGQ";
    TF_VAR_YC_FOLDER_NAME = "aishitalk";
    TF_VAR_YC_FOLDER_DESCRIPTION = "Test YDB serverless telegram bot example";
    TF_VAR_TELEGRAM_BOT_API_KEY = "6673445419:AAHv8BvmRkFP3pNuYMEbO1FUK3rrct9QCUQ";
    TF_VAR_TELEGRAM_API_ID = "22484244";
    TF_VAR_TELEGRAM_API_HASH = "f3d932c9791e675c464d1ad2e3f648b9";
    TF_VAR_TELEGRAM_CLIENT_SESSION = "1ApWapzMBu1_27v-xoAySZWXW7VLsexAcRUy_pSDrwn7adB36mKOWvvApeG1OYQu8YnjpgpI2J89616WEmCRoi5RuEMWOoSvw6FkIOl_zJ0UyfmMD4WOzr8iBkWxcf7KonNmNWoTfhLCdM_BS9TiDhdp_CeolZfJXkjY_eR5p1DJHVzCCIph0HBpZRw504ui6DBfi3YGG_qlhbQ_St7TGdDyZMrIEv9q-lufuZPC1s_7jeUOPI7uMGAlKIUhes539JIQzcssykdGyxveiR1aFy5q0Fw2sizJM6PLWs1UdtseIwYjg2QLkbRsVvFLowe7II7oZ7mkYC2K7phZkDR9EXqRdaVSN2mY=";
    TF_VAR_YC_CLOUD_ID = "b1g5u7k7rq8ba0os2gbn";
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
      "ms-python.python"
      "ms-python.debugpy"
      "hashicorp.terraform"
      "mhutchie.git-graph"
    ];

    # Enable previews
    previews = {
      enable = true;
    };

    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        yc-install = "curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash -s -- -a";
      };
      # Runs when the workspace is (re)started
      onStart = {
        # Example: start a background task to watch and re-build backend code
        # watch-backend = "npm run watch-backend";
      };
    };
  };
}
