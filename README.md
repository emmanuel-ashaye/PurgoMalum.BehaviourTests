# PurgoMalum.BehaviourTests
**How to run tests**
1. Pull the repository
2. In the root directory run this command to setup the test environment
`docker-compose up -d --force-recreate`
3. Once both containrs are running, run this command to kick of the tesst run
`docker exec -it purge-test-runner dotnet test --logger:"nunit;LogFilePath=DockerResults/PurgeMalumTests.xml"`
4. On completion, this command will generate a friendly report
`docker exec purge-test-reporter mono /ReportUnit.1.2.1/tools/ReportUnit.exe /DockerResults /DockerResults`
5. Finally run this command to tear down the environment
`docker-compose down`
6. To load the report in a browser, navegate to Docker Results folder in the repository and click on the index.html file
