# Social Media Hackathon Shiny App

## Summary

This repository cotains an R Shiny Application developed as part of the Government Social Media Hackathon day at Microsoft Campus. 

It was developed collaboratively with a wide range of users with different experiences in Social Media analysis, R and R Shiny. 
## What does the application do?

The application summarises twitter information on jobs as follows for both a local dataset and the live twitter api:

1. Time Series
2. Wordcloud
3. Bar plot
4. Interactive table

## Running the project

To run the project on your machine you need to do the following:

1. Clone the repo.

`git clone https://github.com/adamrobinson361/social-media-hackathon.git`

2. Ensure that you have [Rtools](https://cran.r-project.org/bin/windows/Rtools/) installed if using windows. This is so that packrat can install dependencies correctly.

3. Open the project by double clicking the schools_working_benchmarking.Rproj file.

4. Wait for packrat to install the packages (this can take a while). Until you see the following do not stop the code:

`Packrat bootstrap successfully completed. Restarting R and entering packrat mode...`
   
5. Open the UI.R or Server.R file and hit Run App.    