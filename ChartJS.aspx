<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChartJs.aspx.cs" Inherits="PythonML.Dashboard" %>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>ChartJs</title>
    <link href="bootstrap-4.0.0-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="fontawesome-free-5.0.8/svg-with-js/css/fa-svg-with-js.css" rel="stylesheet" />
    <script src="fontawesome-free-5.0.8/svg-with-js/js/fontawesome-all.min.js"></script>
    <script src="Scripts/Chartjs.js"></script>
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css?family=Lato');
</style>

    <link href="Styles/styles.css" rel="stylesheet" />
    <script src="Scripts/Jquery-1.12.js"></script>
    <script src="Scripts/loader.js"></script>
    <link href="Styles/loader.css" rel="stylesheet" />
</head>

<body>
       <script type="text/javascript">
          
           var dataPoints = [], dataPoints_age_signup = [], dataPoints_Sex_Signup = [], dataPoints_Purchase_Shopping = [], dataPoints_purchase_time = [],
              dataPoints_shopping_duration = [], dataPoints_purchase_value = [];

           var datapointsScatterReneval = [];
           //google.charts.load('current', { 'packages': ['corechart'] });
           //google.charts.setOnLoadCallback(drawGoogleChart);
           //function drawGoogleChart() {
           //    var data1 = google.visualization.arrayToDataTable([
           //     ['Year', 'Sales', 'Expenses'],
           //     ['2004', 1000, 400],
           //     ['2005', 1170, 460]

           //    ]);

           //    var options1 = {
           //        title: 'Company Performance',
           //        curveType: 'function',
           //        legend: { position: 'bottom' }
           //    };

           //    var chart1 = new google.visualization.LineChart(document.getElementById('chartHist_DistributionPurchase'));

           //    chart1.draw(data1, options1);


           //}
           $(document).ready(function () {
               //drawGoogleChart();

             $("#load").hide();
              var random, formData;
               $("#divcontainerRow1").hide();
               $("#divcontainerRow2").hide();
               $("#divcontainerRow3").hide();


               $("#UploadFile").click(function () {
                   $("#lblMessage").html("");
               })

               $("#idhrefClick").click(function () {
                   
                   $("#load").show();
                   setTimeout(function () { $("#load").hide(); }, 2000);
                   FileUpload();

               })
            $('.hreflink').click(function (e) {
                e.preventDefault();//prevent default click
                });   
           })
            
           function FileUpload() {
               
              random=$.now();
              var files = $("#UploadFile")[0].files;
            console.log(files);
            if (files.length > 0)
            {
                formData = new FormData();
                for (var i = 0; i < files.length; i++)
                {
                    formData.append(files[i].name, files[i]);
                }
                formData.append("myname", random);
            }
            else {

                $("#lblMessage").css("color", "red");
                $("#lblMessage").html("No File Choosen");
                $("#load").hide();
               // alert("No File Choose");
                formData = "";
                $("#divcontainerRow1").hide();
                $("#divcontainerRow2").hide();
                $("#divcontainerRow3").hide();
               // location.reload(true);
                
            }
               console.log(formData);
               
               
                $.ajax({
                                        url: "FileUpload.ashx",
                                        method: "POST",
                                        data: formData,
                                     contentType: false,
                                        processData: false,
                                        async: false, 
                                         dataType: 'json',
                                        sucess: function (data) {
                                            
                                        },
                                        error: function (err) {
                                           
                                        }
               });
         
             
               var filepath = document.getElementById("UploadFile");
               var fileName = filepath.value.split('\\')[filepath.value.split('\\').length - 1];
               var NewfileName = random + fileName;
              
                  $.ajax({
                     url: 'http://192.168.1.78:5000/get_data?filename=' + NewfileName,
                   // url: 'http://192.168.1.77:5000/get_data?filename=FraudData.csv',
                                                  type: 'POST',
                                                  async: false, 
                                                   //crossDomain: true,  
                                                    dataType: 'json',
                                                    success: function (response) {
                                                        if (response != null)
                                                        {
                                                           
                                                            
                                                            var jsonVal = $.parseJSON(response)
                                                           
                                                            drawChart(jsonVal);
                                                            
                                                            $("#divcontainerRow1").show();
                                                            $("#divcontainerRow2").show();
                                                            $("#divcontainerRow3").show();
                                                            $("#lblMessage").css("color", "green");
                                                            $("#lblMessage").html("File Sucessfully Uploaded ");
                                                            //$("#load").hide();
                                                            $("#UploadFile").val("");

                                                        }


                                                       
                                                        
                                                
                                                    },
                                                   failure: function (response) {
                                                       console.log(' api call failed');
                                                   },
                                                   error: function (response) {
                                                       console.log(' api call error');
                                                   }
                        
                  });
                 
                 
           }

         

           function drawChart(jsonVal)
           {
               
               if (typeof jsonVal != 'undefined') {

                   for (var i = 0; i < jsonVal.JSONP_data1.data.length; i++) {

                       if (jsonVal.JSONP_data1.data[i].sex == "F") {
                           dataPoints.push({
                               x: jsonVal.JSONP_data1.data[i].signup_time,
                               y: jsonVal.JSONP_data1.data[i].purchase_value, color: "#008000"
                           });
                       }

                      
                       dataPoints_age_signup.push({
                           x: jsonVal.JSONP_data1.data[i].signup_time,
                           y: jsonVal.JSONP_data1.data[i].age, color: "#0000FF"
                       });
                       dataPoints_Sex_Signup.push({
                           x: jsonVal.JSONP_data1.data[i].sex_id,
                           y: jsonVal.JSONP_data1.data[i].age, color: "#FF0000"
                       });
                       dataPoints_Purchase_Shopping.push({
                           x: jsonVal.JSONP_data1.data[i].purchase_value,
                           y: jsonVal.JSONP_data1.data[i].shopping_duration, color: "#FF00FF"
                       });
                       
                       dataPoints_purchase_time.push({
                           x: jsonVal.JSONP_data1.data[i].purchase_time,
                           y: jsonVal.JSONP_data1.data[i].shopping_duration
                       });
                       
                       dataPoints_shopping_duration.push({
                           x:jsonVal.JSONP_data1.data[i].shopping_duration,
                           y: jsonVal.JSONP_data1.data[i].purchase_value, color: "#0000FF"
                       });
                       dataPoints_purchase_value.push({
                           x:jsonVal.JSONP_data1.data[i].purchase_value,
                           y: jsonVal.JSONP_data1.data[i].signup_time, color: "#9400D3"
                       });
                       
                   }


                   var chart_Revenue = document.getElementById('chart_Revenue').getContext('2d');

                   var chart_Female_Revenue = new Chart(chart_Revenue, {
                       // The type of chart we want to create
                       type: 'scatter',
                       data: {
                           datasets: [{
                               label: 'Behavior of Risky Female Customer',
                               backgroundColor: '#008000',
                               
                               data: dataPoints
                           }]
                       },
                       options: {
                           showLines: false,
                           scales: {
                               xAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Signup Time'
                                   }
                                  
                                   
                               }],
                               yAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Purchase Value'
                                   }
                               }]
                           }
                       }
                   });
                   //
                   var chart_age_signup = document.getElementById('chart_age_signup').getContext('2d');

                   var chart_chart_age_signup = new Chart(chart_age_signup, {
                       // The type of chart we want to create
                       type: 'scatter',
                       data: {
                           datasets: [{
                               label: 'Age & Sign up time',
                               backgroundColor: '#0000FF',

                               data: dataPoints_age_signup
                           }]
                       },
                       options: {
                           showLines: false,
                           scales: {
                               xAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Signup Time'
                                   }


                               }],
                               yAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Age'
                                   }
                               }]
                           }
                       }
                   });


                   var chart_sex_signup = document.getElementById('chart_sex_signup').getContext('2d');

                   var chart_chart_sex_signup = new Chart(chart_sex_signup, {
                       // The type of chart we want to create
                       type: 'scatter',
                       data: {
                           datasets: [{
                               label: 'Age & Sex',
                               backgroundColor: '#FF0000',

                               data: dataPoints_Sex_Signup
                           }]
                       },
                       options: {
                           showLines: false,
                           scales: {
                               xAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Sex'
                                   }


                               }],
                               yAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Age'
                                   }
                               }]
                           }
                       }
                   });


                   var chart_purchase_shopping = document.getElementById('chart_purchase_shopping').getContext('2d');

                   var chart_chart_purchase_shopping = new Chart(chart_purchase_shopping, {
                       // The type of chart we want to create
                       type: 'scatter',
                       data: {
                           datasets: [{
                               label: 'Purchase Value & Shopping Duration',
                               backgroundColor: '#FF00FF',

                               data: dataPoints_Purchase_Shopping
                           }]
                       },
                       options: {
                           showLines: false,
                           scales: {
                               xAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Purchase Value'
                                   }


                               }],
                               yAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Duration'
                                   }
                               }]
                           }
                       }
                   });


                  
                   //
                   var chartPie = document.getElementById('chartPie').getContext('2d');

                   var chart_chartPie = new Chart(chartPie, {
                       // The type of chart we want to create
                       type: 'pie',
                       data: {
                           labels: ["TP", "FP", "TN", "FN"],
                           datasets: [
            {
                label: "PIE CHART",
                data: [84, 10, 5,1],
                backgroundColor: [
                    "#FFD700",
                    "#9ACD32",
                    "#f08080",
                    "#87cefa"
                    
                ],
                borderColor: [
                    "#CDA776",
                    "#989898",
                    "#CB252B",
                    "#E39371"
                  
                ],
                borderWidth: [1, 1, 1, 1]
            }
                           ]
                       },
                        options:{
                           responsive: true,
                           title: {
                               display: true,
                               position: "top",
                               text: "Pie Chart",
                               fontSize: 14,
                               fontColor: "#111"
                           },
                           legend: {
                               display: true,
                               position: "bottom",
                               labels: {
                                   fontColor: "#333",
                                   fontSize: 10
                               }
                           }
                       }

                   });
                   //

                   var chart_purchase_time = document.getElementById('chartHist_DistributionPurchase').getContext('2d');

                   var chart_chart_purchase_time = new Chart(chart_purchase_time, {
                       // The type of chart we want to create
                       type: 'scatter',
                       data: {
                           datasets: [{
                               label: 'Purchase Time & Shopping Duration',
                               backgroundColor: '#800080',

                               data: dataPoints_purchase_time
                           }]
                       },
                       options: {
                           showLines: false,
                           scales: {
                               xAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Purchase Time'
                                   }


                               }],
                               yAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Duration'
                                   }
                               }]
                           }
                       }
                   });
                 //
                   var chart_shopping_duration = document.getElementById('chartHist_DistributionShopping').getContext('2d');

                   var chart_chart_shopping_duration = new Chart(chart_shopping_duration, {
                       // The type of chart we want to create
                       type: 'scatter',
                       data: {
                           datasets: [{
                               label: 'Shopping Duration & Purchase value',
                               backgroundColor: '#0000FF',

                               data: dataPoints_shopping_duration
                           }]
                       },
                       options: {
                           showLines: false,
                           scales: {
                               xAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Shopping Duration'
                                   }


                               }],
                               yAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Purchase value'
                                   }
                               }]
                           }
                       }
                   });


                   //

                   var chart_PurchaseValue = document.getElementById('chartHist_DistributionPurchaseValue').getContext('2d');

                   var chart_chart_PurchaseValue = new Chart(chart_PurchaseValue, {
                       // The type of chart we want to create
                       type: 'scatter',
                       data: {
                           datasets: [{
                               label: 'Purchase value & Signup Time',
                               backgroundColor: '#FF0000',

                               data: dataPoints_purchase_value
                           }]
                       },
                       options: {
                           showLines: false,
                           scales: {
                               xAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Purchase value'
                                   }


                               }],
                               yAxes: [{
                                   scaleLabel: {
                                       display: true,
                                       labelString: 'Signup Time'
                                   }
                               }]
                           }
                       }
                   });
               }
             
              
           }

          
    
           </script>
	<header>
		<div class="headermaindiv">
			<div class="container">
				<div class="row">
					<div class="col-md-3">
						<div class="logo"> Dashboard Name</div>
					</div>
					<div class="col-md-9">
						<div class="logout">
							<a href="#"><i class="fas fa-sign-out-alt"></i></a></div>
						<div class="userprofile"><img alt="user pic" src="Images/user-profile.jpg"/>
						</div>
						<div class="userprofile-text">User name</div>
					</div>
				</div>
				
			</div>
		</div>
	</header>
	<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="DBheading">Dashboard Heading</div>
						</div>
					</div>
	</div>
	<div class="Sspace"></div>
	
	<div class="container">
		<div class="row" id="divcontainerRow1">
			<div class="col-md-4">
				<div class="DBgraphmaindiv_chartjs" id="divRiskyFemale">
					<div class="DBgraphheading_chartjs">Behavior of Risky Female Customer</div>
					<div class="DBgraphmaindiv_chartjs" ><canvas id="chart_Revenue"></canvas></div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="DBgraphmaindiv_chartjs">
					<div class="DBgraphheading_chartjs">Age & Sign up time</div>
					<div class="DBgraphmaindiv_chartjs"><canvas id="chart_age_signup"></canvas></div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="DBgraphmaindiv_chartjs">
					<div class="DBgraphheading_chartjs">Sex & Age</div>
					<div class="DBgraphmaindiv_chartjs"><canvas id="chart_sex_signup"></canvas></div>
				</div>
			</div>
		</div>
	</div>
	<div class="Sspace"></div>
	<div class="container">
		<div class="row" id="divcontainerRow2">
			<div class="col-md-4">
				<div class="DBgraphmaindiv_chartjs">
					<div class="DBgraphheading_chartjs">purchase_value & shopping_duration</div>
					<div class="DBgraphmaindiv_chartjs"><canvas id="chart_purchase_shopping"></canvas></div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="DBgraphmaindiv_chartjs">
					<div class="DBgraphheading_chartjs">Distribution of purchase time</div>
					<div class="DBgraphmaindiv_chartjs" ><canvas id="chartHist_DistributionPurchase"></canvas></div>
				</div>
			</div>
            <div class="col-md-4">
				<div class="DBgraphmaindiv_chartjs">
					<div class="DBgraphheading_chartjs">Distribution of shopping Duration</div>
					<div class="DBgraphmaindiv_chartjs"><canvas id="chartHist_DistributionShopping"></canvas></div>
				</div>
			</div>
            </div>
       
       
        </div>
     <div class="Sspace"></div>
        <div class="container">
            <div class="row" id="divcontainerRow3">
                 <div class="col-md-4">
				<div class="DBgraphmaindiv_chartjs">
					<div class="DBgraphheading_chartjs">Distribution of purchase Value</div>
					<div class="DBgraphmaindiv_chartjs"><canvas id="chartHist_DistributionPurchaseValue"></canvas></div>
				</div>
			</div>
                 <div class="col-md-4">
				<div class="DBgraphmaindiv_chartjs">
					<div class="DBgraphheading_chartjs">Pie Chart</div>
					<div class="DBgraphmaindiv_chartjs"><canvas id="chartPie" style="width:290px;height:145px;"></canvas></div>
				</div>
			</div>
                </div>

            </div>
      <div class="Sspace"></div>
        <div class="container">
            <div class="row">
			<div class="col-md-4">
				<div class="Sspace"></div>
				<div class="DBgraphmaindiv">
					<div class="uploaddiv"><input type="file" id="UploadFile" accept=".csv"><a href="#" class="hreflink" id="idhrefClick"><i class="fa fa-upload" aria-hidden="true"></i></a></div>	
				</div>
               
			</div>
            <div class="col-md-4">
                 <div class="Sspace"></div>
                  <div id="load" ><div class="lds-dual-ring"><div></div><div></div></div></div>
                 </div>
                </div>
		</div>
    <div class="Sspace"></div>
        <div class="container">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                <div class="Sspace"></div>
                    <div id="lblMessage"></div>
                </div>
            </div>
        </div>
	
	
	<footer>
		<div class="footermaindiv">
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="DBfootercopyrighttext">© 2018 Nuvento Dashboard</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
	
</body>
</html>
