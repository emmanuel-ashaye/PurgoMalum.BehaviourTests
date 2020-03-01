# PurgoMalum.BehaviourTests
**Introduction**

Test Automation framework built to test functionality of https://www.purgomalum.com
This project was built using .Net Core 3.1 and Visual Studio for Mac IDE.
In order to run tests without this software at least docker and docker-compose will be required.

**Steps**
1. Pull the repository.

2. In the root directory run this command to setup the test environment.

`docker-compose up -d --force-recreate`

3. Once both containrs are running, run this command to kick of the tesst run.

`docker exec -it purge-test-runner dotnet test --logger:"nunit;LogFilePath=DockerResults/PurgeMalumTests.xml"`

4. On completion, this command will generate a friendly report.

`docker exec purge-test-reporter sh CreateReport.sh`

5. Finally run this command to tear down the environment.

`docker-compose down`

6. To load the report in a browser, navegate to DockerResults folder in the repository and click on the dashboard.html file.
