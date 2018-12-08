<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoogleChart.aspx.cs" Inherits="PythonML.Dashboard" %>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Dashboard</title>
    <link href="bootstrap-4.0.0-dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="fontawesome-free-5.0.8/svg-with-js/css/fa-svg-with-js.css" rel="stylesheet" />
    <script src="fontawesome-free-5.0.8/svg-with-js/js/fontawesome-all.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">
    <link href="Styles/loader.css" rel="stylesheet" />
<style>
@import url('https://fonts.googleapis.com/css?family=Lato');
</style>

    <link href="Styles/styles.css" rel="stylesheet" />
    <script src="Scripts/Jquery-1.12.js"></script>
  <%--  graph--%>
    <script src="Scripts/loader.js"></script>
</head>

<body>
       <script type="text/javascript">
      
           google.charts.load('current', { 'packages': ['corechart'] });
           google.charts.setOnLoadCallback(drawChart);
          function drawChart(jsonVal)
          {
              if (typeof jsonVal != 'undefined') {

                  //Behavior of Risky Female Customer

                  var data = new google.visualization.DataTable();
                  data.addColumn('number', 'signup_time');
                  data.addColumn('number', 'purchase_value');

                  var dataAge_Signup = new google.visualization.DataTable();
                  dataAge_Signup.addColumn('number', 'signup_time');
                  dataAge_Signup.addColumn('number', 'age');


                  var dataSex_Signup = new google.visualization.DataTable();
                  dataSex_Signup.addColumn('number', 'Sex');
                  dataSex_Signup.addColumn('number', 'age');

                  var dataPurchase_Shopping = new google.visualization.DataTable();
                  dataPurchase_Shopping.addColumn('number', 'purchase_value');
                  dataPurchase_Shopping.addColumn('number', 'duration');

                  var datapurchase_time = new google.visualization.DataTable();
                  datapurchase_time.addColumn('number', 'purchase_time');

                  var datashopping_duration = new google.visualization.DataTable();
                  datashopping_duration.addColumn('number', 'shopping_duration');


                  var datapurchase_value = new google.visualization.DataTable();
                  datapurchase_value.addColumn('number', 'purchase_value');



                  for (var i = 0; i < jsonVal.JSONP_data1.data.length; i++) {
                      if (jsonVal.JSONP_data1.data[i].sex == "F") {
                          data.addRow([jsonVal.JSONP_data1.data[i].signup_time, jsonVal.JSONP_data1.data[i].purchase_value]);
                      }

                      dataAge_Signup.addRow([jsonVal.JSONP_data1.data[i].signup_time, jsonVal.JSONP_data1.data[i].age]);
                      dataSex_Signup.addRow([jsonVal.JSONP_data1.data[i].sex_id, jsonVal.JSONP_data1.data[i].age]);
                      dataPurchase_Shopping.addRow([jsonVal.JSONP_data1.data[i].purchase_value, jsonVal.JSONP_data1.data[i].shopping_duration]);
                      datapurchase_time.addRow([jsonVal.JSONP_data1.data[i].purchase_time]);
                      datashopping_duration.addRow([jsonVal.JSONP_data1.data[i].shopping_duration]);
                      datapurchase_value.addRow([jsonVal.JSONP_data1.data[i].purchase_value]);
                  }
                  var options = {
                      title: 'Behavior of Risky Female Customer',
                      hAxis: { title: 'Signup Time', minValue: 0, maxValue: 15 },
                      vAxis: { title: 'Purchase Value', minValue: 0, maxValue: 15 },
                      fontSize: 10,
                      pointSize: 5,
                      colors: ['#008000'],
                      legend: 'none'
                  };
                  var chart = new google.visualization.ScatterChart(document.getElementById('chart_Revenue'));
                  chart.draw(data, options);

                  //Age & Sign up time

                  var options_signupAge = {
                      title: 'Age & Sign up time',
                      hAxis: { title: 'Signup Time', minValue: 0, maxValue: 15 },
                      vAxis: { title: 'Age', minValue: 0, maxValue: 15 },
                      fontSize: 10,
                      pointSize: 5,
                      colors: ['#0000FF'],
                      legend: 'none'
                  };
                  var chart_signupAge = new google.visualization.ScatterChart(document.getElementById('chart_age_signup'));
                  chart_signupAge.draw(dataAge_Signup, options_signupAge);

                  //Sex_Signup

                  var options_sexAge = {
                      title: 'Sex & Age',
                      hAxis: { title: 'Sex', minValue: 0, maxValue: 15 },
                      vAxis: { title: 'Age', minValue: 0, maxValue: 15 },
                      fontSize: 10,
                      pointSize: 5,
                      colors: ['#FF0000'],
                      legend: 'none'
                  };
                  var chart_sexAge = new google.visualization.ScatterChart(document.getElementById('chart_sex_signup'));
                  chart_sexAge.draw(dataSex_Signup, options_sexAge);

                 
                  //Purchase_Shopping

                  var options_Purchase_Shopping = {
                      title: 'Purchase Value & Shopping Duration',
                      hAxis: { title: 'purchase Value', minValue: 0, maxValue: 15 },
                      vAxis: { title: 'Duration', minValue: 0, maxValue: 15 },
                      fontSize: 10,
                      pointSize: 5,
                      colors: ['#FF00FF'],
                      legend: 'none'
                  };
                  var chart_Purchase_Shopping = new google.visualization.ScatterChart(document.getElementById('chart_purchase_shopping'));
                  chart_Purchase_Shopping.draw(dataPurchase_Shopping, options_Purchase_Shopping);
                 
                  //purchase_time

                  var options_purchase_time = {
                      'title': 'Distribution of purchase time',
                      hAxis: { title: 'purchase Time' },
                      legend: { position: 'none' },
                      colors: ['#800080'],
                      histogram: {
                          bucketSize: 1
                      }
                  };

                  var chart_purchase_time = new google.visualization.Histogram(document.getElementById('chartHist_DistributionPurchase'));
                  chart_purchase_time.draw(datapurchase_time, options_purchase_time);


                  //shopping_duration
                  var options_shopping_duration = {
                      'title': 'Distribution of shopping Duration',
                      hAxis: { title: 'shopping Duration' },
                      legend: { position: 'none' },
                      colors: ['#0000FF'],
                      histogram: {
                          bucketSize: 1
                      }
                  };

                  var chart_shopping_duration = new google.visualization.Histogram(document.getElementById('chartHist_DistributionShopping'));
                  chart_shopping_duration.draw(datashopping_duration, options_shopping_duration);
        

                  //

                  var options_purchase_value = {
                      'title': 'Distribution of purchase value',
                      hAxis: { title: 'purchase value' },
                      legend: { position: 'none' },
                      colors: ['#9400D3'],
                      histogram: {
                          bucketSize: 1
                      }
                  };

                  var chart_purchase_value = new google.visualization.Histogram(document.getElementById('chartHist_DistributionPurchaseValue'));
                  chart_purchase_value.draw(datapurchase_value, options_purchase_value);

                  //pie chart

                  var datapie_chart = google.visualization.arrayToDataTable([
                  ['', ''],
                  ['TP', 84],
                  ['FP', 10],
                  ['TN', 5],
                  ['FN', 1]
          
              ]);

                  var options = {
                      title: '',
                      startAngle: 140,
                      slices: { 0: { color: '#FFD700',offset:0.1 }, 1: { color: '#9ACD32' }, 2: { color: '#f08080' }, 3: { color: '#87cefa' } }
                      // is3D: true,
                  };

                  var chart = new google.visualization.PieChart(document.getElementById('chartPie'));

                  chart.draw(datapie_chart, options);

              }
          }

          $(document).ready(function () {
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
                                                           
                                                            $("#divcontainerRow1").show();
                                                            $("#divcontainerRow2").show();
                                                            $("#divcontainerRow3").show();
                                                            var jsonVal = $.parseJSON(response)
                                                            
                                                            drawChart(jsonVal);
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
				<div class="DBgraphmaindiv" id="divRiskyFemale">
					<div class="DBgraphheading">Behavior of Risky Female Customer</div>
					<div class="Dbgraphmaindiv" id="chart_Revenue"></div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="DBgraphmaindiv">
					<div class="DBgraphheading">Age & Sign up time</div>
					<div class="Dbgraphmaindiv" id="chart_age_signup"></div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="DBgraphmaindiv">
					<div class="DBgraphheading">Sex & Age</div>
					<div class="Dbgraphmaindiv" id="chart_sex_signup"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="Sspace"></div>
	<div class="container">
		<div class="row" id="divcontainerRow2">
			<div class="col-md-4">
				<div class="DBgraphmaindiv">
					<div class="DBgraphheading">purchase_value & shopping_duration</div>
					<div class="Dbgraphmaindiv" id="chart_purchase_shopping"></div>
				</div>
			</div>
			<div class="col-md-4">
				<div class="DBgraphmaindiv">
					<div class="DBgraphheading">Distribution of purchase time</div>
					<div class="Dbgraphmaindiv" id="chartHist_DistributionPurchase"></div>
				</div>
			</div>
            <div class="col-md-4">
				<div class="DBgraphmaindiv">
					<div class="DBgraphheading">Distribution of shopping Duration</div>
					<div class="Dbgraphmaindiv" id="chartHist_DistributionShopping"></div>
				</div>
			</div>
            </div>
       
       
        </div>
     <div class="Sspace"></div>
        <div class="container">
            <div class="row" id="divcontainerRow3">
                 <div class="col-md-4">
				<div class="DBgraphmaindiv">
					<div class="DBgraphheading">Distribution of purchase Value</div>
					<div class="Dbgraphmaindiv" id="chartHist_DistributionPurchaseValue"></div>
				</div>
			</div>
                 <div class="col-md-4">
				<div class="DBgraphmaindiv">
					<div class="DBgraphheading">Pie Chart</div>
					<div class="Dbgraphmaindiv" id="chartPie"></div>
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
