# README

This README includes the steps that are necessary to get the
application up and running.


- Installation Guide
  > ruby 2.6.3
  To install ruby using RVM, please follow the link below:
  
  ```
  https://rvm.io/rvm/install

  rvm install ruby 2.6.3
  ```
  > postgres
  
  ```
  MAC OSX: brew install postgresql
  LINUX: apt-get install postgresql
  
  ```
  > yarn

  ```
  MAC OSX: brew install yarn
  LINUX: apt-get install yarn
  ```
- Services startup
  >  RUBY: If multiple ruby versions installed in your system, then use command:

  ``` 
  rvm use 2.6.3 
  ```
  > PSQL: 
  
  ```
    MAC: brew services start postgresql
    LINUX: systemctl start postgresql
    
    Configure postgresql - psql postgres
    Create user postgres -CREATE ROLE postgres WITH LOGIN PASSWORD 'postgres' SUPERUSER;
  ``` 
  > To install the system dependencies, please follow the below commands.
  
   ```
    cd patient_portal
    bundle install
   ```
* System startup: 
  > CREATE DATABASE: 
   ```
    rails db:create
   ```
   > Run Migrations:
   
   ```
    rails db:migrate
   ```
  > Run Seed:
   
   ```
   rails db:seed
   ```
   Or collectively you can use:
   ``` 
    rails db:prepare
   ```
* Configuration
  > Open config/database.yml and update the user and password based upon configurations you have for DB.


* Services (job queues):
  > To perform the background services using Sidekiq start Sidekiq with following command: 

  ```
  bundle exec sidekiq
  ```

* Run application server:
 
  ```
  rails s
  ```
  > open browser and go to localhost:3000
  > The default login details added by seed, which can be used for login:
  ```
  email: user@ephicacy-assignment.com,
  password: Assignment1
  ```
  > Login with above details, and you're all set to explore the application.

##### Please note: Sample files are added to import in public folder of application in various file formats:
```
 Kindly refer: public/sample_patients.csv, public/sample_patients.xml, public/sample_patients.json
```