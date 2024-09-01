# Assignment

You have been hired as a new Data Engineer at CoreDataEngineers. The CoreDataEngineers infrastructure is based on the Linux Operating System. Your manager has tasked you with the responsibility of managing the company’s data infrastructure and version control tool.

## Task 1

1. Your manager has assigned you the task of building a **Bash** script (use only bash scripting) that performs a simple ETL process:

   - **Extract:** Download a CSV file. You can access the CSV using this [link](https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv). Save it into a folder called `raw`. Your script should confirm that the file has been saved into the `raw` folder.

   - **Transform:** After downloading the file, perform a simple transformation by renaming the column named `Variable_code` to `variable_code`. Then, select only the following columns: `year, Value, Units, variable_code`. Save the content of these selected columns into a file named `2023_year_finance.csv`. This file should be saved in a folder called `Transformed`, your script should confirm that it was loaded into the folder.

   - **Load:** Load the transformed data into a directory named `Gold`. Also, confirm that the file has been saved into the folder.

   Note: Use environment variables for the URL, and call it in your script. Write a well-detailed script, add sufficient comments to the script, and print out information for each step.

2. Your manager has asked you to schedule the script to run daily using cron jobs (research this). Schedule the script to run every day at 12:00 AM.

## Task 2

3. Write a Bash script to move all CSV and JSON files from one folder to another folder named `json_and_CSV`. Use any Json and CSV of your choice, the script should be able to work with one or more Json and CSV files.


## Task 3

4. CoreDataEngineers is diversifying into the sales of goods and services. To understand the market, your organization needs to analyze their competitor, `Parch and Posey`. Download the CSV file using this [link](https://we.tl/t-2xYLL816Yt) to your local PC. After downloading, do the following:

   - Write a Bash script that iterates over and copies each of the CSV files into a PostgreSQL database (name the database `posey`).

   - After this, write SQL scripts with detailed comments to answer the following questions posed by your manager (Ayoola):

   - Find a list of order IDs where either `gloss_qty` or `poster_qty` is greater than 4000. Only include the `id` field in the resulting table.

   - Write a query that returns a list of orders where the `standard_qty` is zero and either the `gloss_qty` or `poster_qty` is over 1000.

   - Find all the company names that start with a 'C' or 'W', and where the primary contact contains 'ana' or 'Ana', but does not contain 'eana'.

   - Provide a table that shows the region for each sales rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) by account name.

Document the solutions to these questions using a well-detailed GitHub README file. Upload all scripts into a folder named `Scripts`. Inside the `Scripts` folder, create separate folders to store the Bash scripts and SQL scripts. Push all work to GitHub (do not push the CSV files). Ensure that you do not push directly to the master branch but instead merge to master via a pull request (you should know what to do). Additionally, create an architectural diagram of the ETL pipeline as requested by your manager.

# Solution

## Task 1

1. **Environment Variable:**
   - The URL of the CSV file is stored in an environment variable `CSV_URL` to make the script more flexible and reusable.

2. **Extraction:**
   - The script creates a `raw` directory if it doesn't exist.
   - It then downloads the CSV file into this directory using `curl`.
   - The script checks if the file has been successfully downloaded and saved.

3. **Transformation:**
   - The script creates a `Transformed` directory.

    a. **Extracting and Renaming the Header:**
    - The `head -n 1` command extracts the first line (the header) of the CSV file.
    - The `sed 's/Variable_code/variable_code/'` command replaces `Variable_code` with `variable_code` in the header string.

    b. **Extracting the Data:**

    - The `tail -n +2` command extracts the data starting from the second line (skipping the header) and saves it in a temporary file `temp_data.csv`.

    c. **Combining the Header and Data:**

    - The `cut -d',' -f1,2,3,4` command selects the first four columns (`year`, `Value`, `Units`, `variable_code`) from the data in the the header and temporary file.
    - The `echo "$header"` command adds the modified header back to the beginning of the file, and the combined result is saved as `2023_year_finance.csv`.

    d. **Cleanup:**

    - The temporary file `temp_data.csv` is deleted after the transformation is complete to keep the workspace clean.

4. **Loading:**
   - The script creates a `Gold` directory.
   - It copies the transformed file into the `Gold` directory.
   - The script checks if the file has been successfully moved.

5. **Orchestration Using Crontab:**
   - The script includes comments to explain each step.
   - It also prints out messages to inform the user about the status of each process in a log file.
   - `0 0 * * *`: This specifies the time when the cron job should run. It means "run at 12:00 AM every day."
   - `>> logs/etl_script.sh.log 2>&1`: This redirects the standard output and error output of the script to a log file.
   - To schedule the scripts to run daily at 12:00 AM using cron jobs.


## Task 2

### Explanation

1. **Destination Directories:**
   - The script starts by defining the `destination_dir`, which is the directory where you want the files to be moved using the current working directory as the default location for the files to be moved.

2. **Create the Destination Directory:**
   - The `mkdir -p "$destination_dir"` command creates the destination directory if it doesn't already exist.

3. **Move CSV Files:**
   - The script uses `mv *.csv "$destination_dir"` to move all `.csv` files to the destination directory.

4. **Move JSON Files:**
   - Similarly, `mv *.json "$destination_dir"` moves all `.json` files to the destination directory.

5. **Check if Files Were Moved:**
   - The script checks if any `.csv` or `.json` files are present in the destination directory after the move. If files were moved, it prints a success message; otherwise, it indicates that no files were found to move.

## Task 3