# Reddit War Opinion
***

## Table of Contents
***
* Introduction
  * Overview
  * Problem Description
* Data Source
* Project Architecture
    * Technologies
* Dashboard
* Reproducing Project
* Future Improvements
***

## Introduction
### Overview
This project reads and analyses reddit comments associated with the ongoing Israel-Palestine conflict.
For the past several months, this conflict has taken center stage for current affairs across the world.

As part of my final project for the Data Engineering Zoomcamp 2024, I have selected the Daily Public Opinion on Isreal-Palestine War dataset from kaggle. This dataset is a daily extract of people's comments on the online platform Reddit across major Subreddits related to the conflict.

### Problem Description
This project aims to successfully read and analyse comments and posts by users on the social media platform Reddit.
* Create an end-to-end pipeline to read, transform and move data to a Data Warehouse
* Design a Dashboard to analyse Posts and Comments by users on the Platform.
    * How active are the Subreddits?
    * What is the sentiment observed in the posts and comments?
***

## Data Source
The project's dataset can be accessed on kaggle using this [link](https://www.kaggle.com/datasets/asaniczka/reddit-on-israel-palestine-daily-updated/data).
The columns within the dataset are as follows: 
1. `comment_id`: Unique identifier for each comment.
2. `score`: Score assigned to the comment by Reddit users, It's the number of upvotes minus the number of downvotes.
3. `self_text`: Text content of the comment.
4. `subreddit`: Subreddit where the comment was posted, Subreddits are subsidiary threads or categories within the Reddit website. They allow users to focus on a specific interest or topic in posting content.
5. `created_time`: Timestamp indicating when the comment was created.
6. `post_id` :Unique identifier for the post associated with the comment.
7. `author_name`: Username of the author who posted the comment.
8. `controversiality`: It's a Boolean value indicating whether or not a comment has received a similar amount of upvotes to downvotes, hence being controversial.
9. `ups`: Number of upvotes received by the comment.
10. `downs`: Number of downvotes received by the comment.
11. `user_is_verified`: Indicates whether the user account is verified.
12. `user_account_created_time`: Timestamp indicating when the user account was created.
13. `user_awardee_karma`: Reddit karma is a user score that represents how much you've contributed to the Reddit community.Awardee Karma is when someone gives you an award. You will get around 10 awardee karma each time someone gives you an award. And yes it still adds to your total karma.
14. `user_awarder_karma`: Karma received as an awarder.
15. `user_link_karma`: Karma received from links posted.
16. `user_comment_karma`: Karma received from comments made.
17. `user_total_karma`: Total karma received by the user.
18. `post_score`:Score assigned to the post associated with the comment.
19. `post_self_text`: Text content of the post.
20. `post_title`: Title of the post.
21. `post_upvote_ratio`: Ratio of upvotes to total votes for the post.
22. `post_thumbs_ups`: Number of upvotes received by the post.
23. `post_total_awards_received`: Total number of awards received by the post.
24. `post_created_time`: Timestamp indicating when the post was created.
***

## Project Architecture
This Architecture depicts an end-to-end overview of the Project and its components.

### Technologies
* **Cloud**: [Google Cloud Platform (GCP)](https://cloud.google.com/?hl=en)
* **Data Lake (DL)**: [Google Cloud Storage (GCS)](https://cloud.google.com/storage?hl=en)
* **Data Warehouse (DWH)**: [BigQuery](https://cloud.google.com/bigquery?hl=en)
* **Infrastructure-as-Code (IaC)**: [Terraform](https://www.terraform.io/)
* **Worflow Orchestration**: [Mage AI](https://www.mage.ai/)
* **Data Transformation**: [Dbt](https://www.getdbt.com/)
* **Visualisation**: [Looker Studio](https://cloud.google.com/looker-studio?hl=en)

## Dashboard
![Dashboard Image]

## Reproducing Project
#### Prerequisites
1. [Google Cloud Platform Account](https://cloud.google.com/?hl=en)
2. [Kaggle Account](https://www.kaggle.com/)

> [!NOTE]
Setting Up GCP with your google account allows for $300 worth credit on a 90-day trial

1. Google Cloud Platform (GCP)
    * Setup GCP account and create a new Project with a `Project-ID`. Once created, navigate to [service                 accounts](https://cloud.google.com/iam/docs/service-accounts-create), to create a service-account, for which, you will have to also enable the "IAM API" & "Compute Engine API". Enable the folowing roles for the Service Account:
        * `BigQuery Admin`
        * `Storage Admin`
        * `Storage Object Admin`
        * `Compute Admin`
    
        Alternately, you could work with just providing the `Owner` role, however this might be less secure, incase of loss of credentials.
    * Create and Download the service account key file (JSON). This will be used for authentication purposes when using Mage AI, dbt etc. Save the file in "~/Users/<laptop-username>/.gc/". I have used 'my-credentials.json' as filename to make it more simpler.
    * Create SSH key Pairs. This will be used to link your local machine to a VM. Use the following command in bash to create the key pairs. Switch 'USERNAME' with your computers name and KEY_FILENAME with a suitable name for your key files.
        ```bash
        ssh-keygen -t rsa -f ~/Users/<laptop-username>/.ssh/KEY_FILENAME -C USERNAME -b 2048
        ```
        `ssh-keygen` saves your private key file to `~/.ssh/KEY_FILENAME` and your public key file to `~/.ssh/KEY_FILENAME.pub`.
    * Navigate to metadata section of your Project's Compute Engine. Switch to the SSH KEYS tab and copy paste only the public key here and save.
    * Next Create a VM Instance by navigating to *Cloud Compute > VM Instance*. Create a new instance and:
        * Choose name `<instance-name>`
        * Pick region. You can check out the regions [in this link](https://cloud.google.com/about/locations). I have chosen `australia-southeast2`.
        * Pick a _E2 series_ instance. A _e2-standard-4_ instance is recommended (2 vCPUs, 4GB RAM)
        * Change the boot disk to _Ubuntu_. The _Ubuntu 20.04 LTS_ version is recommended. Also pick at least 0GB of storage.
        * Leave all other settings on their default value and click on _Create_.
    
        > [!IMPORTANT]
        Make sure that you use the same region for all of your Google Cloud components
    
    * In your local bash terminal you can now, navigate to the VM using the following command. Here, you substitute USERNAME and KEY_NAME with the values you chose earlier:
        ```bash
        ssh -i ~/.ssh/KEY_NAME USERNAME@EXTERNAL_IP
        ```
        You will now be connecting with the VM.
        Alternately, in the location '~/Users/<Laptop-username>/.ssh/' create a config file and write the following config:
        * ```
            Host <VM-Name>
            HostName <external-ip>
            User <ssh-key-username>
            IdentityFile <ssh-key-location>
            ```
        If you run ssh <VM-Name> now, it should run the VM without typing out the entire command.
    
    * Install Python on VM using [Anaconda Distribution](https://www.anaconda.com/download/success). I chosen Linux 64-Bit ( x86) Installer. Use 
        ```bash 
        wget <link-to-distribution>
        ```
        Python is automatically added to VM ENVIRONMENT PATH.
    * To install docker:
        * ```bash
            sudo apt-get update
            ```
        * ```bash
            sudo apt-get install docker.io
            ```
        * Docker might not run without sudo. In that case, follow this [link](https://github.com/sindresorhus/guides/blob/main/docker-without-sudo.md) to run docker without sudo.
        * We also need docker-compose. Create a directory using `mkdir bin`. You can obtain docker-compose [here](https://github.com/docker/compose/releases), and use `wget <release-link> -0 docker-compose`. I used version 2.2.3. To make the file executable use the command `chmod +x docker-compose.
        This should allow you to use docker-compose anywhere in the VM.
    
    * Use `nano .bashrc` to open "".bashrc" executable file. At the end of the file, write: export PATH="${HOME}/bin:${PATH}". Press `CTRL+O` to save, `CTRL+X` to exit and `source .bashrc` re-evaluate VM. This has added "~/bin/" to VM $PATH which will allow us to execute commands from anywhere in the VM.
    * Install Terraform, by copying link address to distribution run `wget <link-address>` in "~/bin/". I have used Linux distribution AMD64 version. Unzip the distribution, which should add terraform executable in bin folder.
    * On you local machine, open another bash terminal, while the VM is running. Navigate to location of Service Account Key File, located in "~/Users/<laptop-username>/.gc/" and, using bash, run `sftp <VM-Name>`. This will open an sftp terminal. Create a directory .gc where you will copy the my-credentials.json to. Exit sftp. run `ssh <VM-Name>` to log into VM using new terminal and locate the JSON file in .gc directory to make sure, file has been transferred.
    * To Authenticate Google Creds for your application, in your VM bash terminal run 
    `export GOOGLE_APPLICATION_CREDENTIALS=~/.gc/my-credentials.json`. 
    You can check the variable using `echo $GOOGLE_APPLICATION_CREDENTIALS`. 
    Execute `gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS` to authenticate your gcloud account in VM.

2. Kaggle
    If your Kaggle account has already been created, navigate to [link](https://www.kaggle.com/settings/account). Create a New Token and save the file as kaggle.json.
***

#### Running Project
1. Clone Repo
    Log into your VM using a bash terminal and `ssh <VM-Name>` and clone the reddit-war-opinion repo using this [link](https://github.com/Shaunofthedead19/reddit-war-opinion.git).
    Currently while we have all the prerequisites installed for this project the repo mentioned above will contain all the files required to successfully execute the project. However, we still have to add my-credentials.json and kaggle.json locations within the reddit-war-opinion project to successfully authenticate and create resources.
2. Add Key File Locations to Project
    The two key files my-credentials.json and kaggle.json need to be stored in a location where both terraform and Mage AI can access them. Since, we are running a docker image to run Mage AI, the home directory (/home/src/) is actually configured as '~/home/username/reddit-war-opinion/mage/', i.e. the home directory for Mage AI starts from the location: '~/home/username/reddit-war-opinion/mage/' and its files and subdirectories. The two key files would ideally house in this location as it also allows our pipelines to detect the files more easily.
    From the home directory in bash (/home/username/), use, the following to copy <key-file>:
    ```bash
    cp '~/.gc/my-credentials..json' '~/reddit-war-opinion/mage/my-credentials.json'
    ```
    and from a bash terminal in your local machine containing kaggle.json sftp to '~/reddit-war-opinion/mage/', as was done with the my-credentials.json earlier.
    
3. On your local machine, open VS Code. In the bottom let corner select `><` to open a remote window and select 'Connect to Host'. Your VM should show up as one of the options. Select the VM. When it opens, select Open Folder in the File Explorer on the left panel and from the dropdown dislaying contents of your VM, select the repo directory. This will open the directory in VM. From the directory navigate to '/terraform/'. This is a variable.tf file which contains dictionaries necessary for the configurations in main.tf. Edit "credentials" variable to set the default value as location of the <key-file>.json file you just copied. This will allow Terraform to authenticate properly. 
Then Using the bash terminal logged into your VM, navigate to terraform folder of the cloned repo ('~/reddit-war-opinion/terraform/')
and execute the following commands to create GCP resources, **Google Cloud Storage Bucket** & **Google Cloud Bigquery Dataset**:
    *   To initialize:
    ```bash
    terraform init
    ```
    * Build:
    ```bash
    terraform plan --var="project=<ENTER-PROJECT-ID>"
    ```
    * Run:
    ```bash
    terraform apply --var="<ENTER-PROJECT-ID>"
    ```
    The terraform directory contains `main.tf` and `variable.tf` files, which contain the definition of the GCS Bucket and BigQuery dataset to be created, and the values configured to variables.
4. Similarly, in the Visual Studio File Explorer, navigate to '~/reddit-war-opinion/mage/' and edit  From the terminal, navigate to mage directory of cloned repo ('~/reddit-war-opinion/mage/'). This folder contains the files necessary to build Mage AI image and run our pipelines and tables. Use the following command to build and run the Mage AI docker image of our project.
    ```bash
    docker-compose up -d --build
    ```
    Once the docker imag is built, you can check if the image is running using the command `docker ps`. This image is configured to run on the port: 6789.
5. Open terminal and navigate to the 'PORTS' tab. From there, select 'Forward a Port'. Here we are going to connect to the Mage AI localhost. Type the Port number 6789 and it should link you to the http://localhost:6789/ .
6. Once in the Mage AI web interace in localhost navigate to Pipelines section from the left panel. It should dislay the pipelines:
    * `api_to_gcs`: This pipeline gets the data from kaggle source, by access the <kaggle-file>.json file from mage directory, and authenticating credentials. It then conducts some transformations to clean the data and exports to gcs bucket configured in our main.tf terraform files. Ultimately, the pipeline cleans residual data files and triggers our second pipeline.
    * `gcs_to_bigquery`: This pipeline loads data from gcs, carries out further transforations before writing the data to BigQuery using our rwo_dataset configured in main.tf. Then, it runs a `dbt build --select +fact_comments+ --vars '{"is_test_run": 'false'}'` in prod environment to execute some transformations in dbt and building the data models into prod_rwo_dataset in BigQuery, configured in main.tf.
    
    Open BigQuery in your project to check out how the datasets and tables are built. Note: stg_rwo_dataset might not show tables as we have built our data directly in Production environment. You could edit the pipeline gcs_to_bigquery to configure env as 'dev' and work on your changes there.
7. To replicate the dashboard, select the [link](). Create a copy.
From the copy, navigate to resource tab and select Manage added data sources. If a data source is present, EDIT, otherwise ADD A DATA SOURCE -> BigQuery -> My Projects -> Project-ID -> prod_rwo_dataset -> fact_comments. This should connect the dashboard to the loaded data and voila! You can edit your data sources and pretty much everything in you repo, as per you configurations. Enjoy!

#### Tearing Everything Down
Once you are done playing around with the project, follow these steps to pull down the project, so you don't exhaust your credits:
* From the bash terminal logged into your VM Instance, run `docker ps` to check if Mage AI image is running. Copy container ID and execute the command `docker stop <CONTAINER ID>. This will stop your docker container from running.
* Navigate to the terraform directory of the repo, and run `terraform destroy`. This initiates the process to pull down any GCP resources created using a terraform template. type 'yes' when asked for confirmation, and the resources will be destroyed.
* Finally run `sudo shutdown now` to shutdown you VM!

And your project has been shutdown completely without the risk of incurring any costs from stray resources stil running.
    




