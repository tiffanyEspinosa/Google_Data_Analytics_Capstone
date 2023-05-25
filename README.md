<h1>Google Data Analytics Capstone</h1>

<h2><a href="https://public.tableau.com/views/CourseraCapstoneVisualizations/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link">View My Tableau Dashboard Here!</a></h2>

<h2>Description</h2>

<p>This project is part of the Google Data Analytics Certificate Capstone. I chose to do Case Study 1.</p>

<p>I am a junior data analyst working in the marketing analyst team at Cyclistic, a bike company in Chicago with over 5,800 bikes and 600 docking stations. The company was started in 2016, and it offers a bike-share service where people can rent a bike at one location and return it at another. They offer a few price plans: single-ride passes, full-day passes, and annual memberships, which are the most profitable group. The main goal is to convert casual riders into annual Cyclistic members.</p>

<p>Business task: Understand how annual members and casual riders use Cyclistic bikes differently.</p>

<h2>Analysis Results</h2>

<p>In 2022, there were over 4 million rides, with 1.6 million from casual users and 2.4 million from annual members. </p>

<p>Annual members had a shorter average ride length than casual riders but used the service more frequently compared to casual riders. Wednesday was the most popular day for annual members, whereas Saturday was the most popular for casual riders. Casual riders are possibly using the bikes more frequently on Saturday as their primary mode of transportation when out shopping, socializing, etc. In contrast, members probably use the service as their primary mode of transportation for commuting, which could explain why annual members have more trips on average, as they are going to and from work each day.</p>

</p>Casual riders steadily increased the number of rides as the day progressed and peaked at 5:00 PM, whereas annual members had a slight peak at 8:00 AM and a larger peak at 5:00 PM. This shows that annual members probably use the service as their way of commuting to and from work, whereas casual riders may only need to use it to return from work, as they may have another type of transportation to work.</p>

<p>The Classic Bike was the most popular for casual users and annual members, and annual members did not use the docked bikes.</p>

<h2>Workflow</h2>

<p>I first read through the prompt and the roadmap provided by the Coursera packet. </p>

<h3>Excel</h3>

<p>Afterward, I downloaded my data and followed their suggestion of using Excel at the start. However, I ended up deleting the work I did in Excel using R because I did not like how it transferred. </p>

<p>The roadmap had me add a  ‘ride_length’ column and a ‘day_of_week’ column for each of the 12 files: </p>

 - Created a column called “ride_length” (which subtracted the start time of the ride from the end time), and I changed the format to HH:MM:SS<br />
 - Created a column called “day_of_week,” which took the date and found which day of the week it was, and correlated it to a number (Sunday = 1, Monday = 2…). The formula was ‘=WEEKDAY(C2, 1)’. C2 represents the cell that contained the start time and day for the ride, and ‘1’ told the program to assign Sunday to 1 and so on.<br />

<h3>R</h3>

<p>I uploaded the 12 Excel files into R and manipulated, cleaned, and analyzed the data. Please see Capstone.R for my full code.</p>

<h3>Explanation of why I removed the Excel columns:</h3>

<p>I followed the instructions of the roadmap and added the two columns; however, I preferred the results in R than I did using Excel. </p>

<p>The ‘day_of_week’ column had numbers that represented the day of the week, whereas I coded a new column, ‘day_of_week2’, that used the actual day of the week. That is why I deleted the original ‘day_of_week’ column and renamed the ‘day_of_week2’ column to ‘day_of_week.’</p>

<p>The ‘ride_length’ column I created in Excel did not transfer properly to R. I formatted it to be in HH:MM:SS format. However, when I viewed the data output, it formatted it as YYYY-MM-DD HH:MM:SS (ex: ‘1899-12-31 00:02:57’ instead of ‘00:02:57’). In order to correct this error, I deleted this column and remade the column in R by subtracting the started_at from the ‘ended_at’ columns and formatting it in units of minutes.</p>

<h3>Tableau</h3>

<p>I downloaded my R code and uploaded it into Tableau. After some trial and error, I was able to plot my data to show the relationships between how casual versus annual users interacted with Cyclistic bikes. </p>

<h2>My recommendations to Cyclistic are:</h2>

 - Demonstrate the amount of savings per customer when they switch to annual members.<br />
 - Investigate why some customers are keeping the bikes for over 24 hours.<br />
 - Highlight the community aspect of being a member: Develop an online community where people can share their trips and the different places they visit<br />
 - Highlight the health and environmental benefits of biking daily versus using a car.<br />


<h2>Tools/Technologies Used</h2>

 - <b>R</b><br />
 - <b>Tableau</b><br />
 - <b>Excel</b><br />

<h2>Data</h2>
<p>I used the 2022 data from <a href="https://divvy-tripdata.s3.amazonaws.com/index.html">Divvy Trip Data</a>.</p>
