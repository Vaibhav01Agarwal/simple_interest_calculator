import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {  
  runApp( MaterialApp(   
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator",
    home: SIprogram(),
    theme : ThemeData (   
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,  
      accentColor :  Colors.indigoAccent
    ),
  ));
}

class SIprogram extends StatefulWidget {
  const SIprogram({ Key? key }) : super(key: key);

  @override
  _SIprogramState createState() => _SIprogramState();
   
}

class _SIprogramState extends State<SIprogram> {

     var _formKey  =  GlobalKey<FormState>();

  var _currencies = ['Rupees' , 'Dollars' , 'pound'];
  final _minimumPadding  = 2.0;  
  var _currentItemSelected = '';

  @override  
  void initState () {  
    super.initState();
     _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = '' ;
  @override
     
  Widget build(BuildContext context) {

    //  TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
  //    resizeToAvoidBottomInset: false,
      appBar: AppBar( title: Text('Simple Interest Calculator'),
      ),
      
      body: Form( 
            key: _formKey,
            child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(   
          children: <Widget> [  
             getImage(),

            Padding(
                padding: EdgeInsets.only(top: 20),
                child: TextFormField(   
                keyboardType: TextInputType.number,
//                style: textStyle,
                 controller: principalController,
                 validator:  ( value) {    
               //    if (value.isEmpty) {   
                //     return 'please enter principal amount';
                 //  }
                 },
                decoration: InputDecoration(   
                  labelText: 'Principle',
                  hintText: 'Enter Principal e.g. 12000',
  //                labelStyle: textStyle,
                  border: OutlineInputBorder(  
                    borderRadius: BorderRadius.circular(10.0)
                  )
                ),
              ),),


              Padding(
                padding: EdgeInsets.only(top: 20),
                child:TextFormField(   
                keyboardType: TextInputType.number,
    //            style: textStyle,
                   controller: roiController,
                   validator: (value)  {   
            //         if (value.isEmpty)  {    
              //         return 'please enter rate of interest';
                //     }
                   },
                decoration: InputDecoration(   
                  labelText: 'Rate of Interest',
                  hintText: 'In percent',
      //            labelStyle : textStyle,
                  errorStyle: TextStyle(   
                    color: Colors.yellowAccent,
                    fontSize: 15.0
                  ),
                  border: OutlineInputBorder(  
                    borderRadius: BorderRadius.circular(10.0)
                  )
                ),
              )),

            Padding( 
              padding: EdgeInsets.only(top: 20 , bottom: _minimumPadding),
              child: Row(  
              children: [   
                      
                      
               Expanded(child:  TextField(   
                keyboardType: TextInputType.number,
        //        style: textStyle,
                  controller: termController,
                decoration: InputDecoration(   
                  labelText: 'Term',
                  hintText: 'Time in Years',
           //       labelStyle: TextStyle,
                  border: OutlineInputBorder(  
                    borderRadius: BorderRadius.circular(10.0)
                  )
                ),
              )),

                    Container(width: _minimumPadding * 10,),

               Expanded(child:  DropdownButton<String>(
                  items: _currencies.map((String value) {   
                    return DropdownMenuItem<String>(
                      value: value,
                      child:  Text(value),
                    );
                  }).toList(),
                  value:  _currentItemSelected,
                    onChanged: (newValueSelected){  

                      _onDropDownItemSelected(newValueSelected);
                     }, 

                  ))

              ],
            )),

             Padding(
               padding: EdgeInsets.only(bottom: _minimumPadding, top: _minimumPadding ),
               child: Row(children: <Widget> [  
                
                Expanded(
                  child: RaisedButton(    
                    color: Theme.of(context).accentColor,
                    textColor: Theme.of(context).primaryColorDark,
                    child: Text(
                      'Calculator' ,
                       textScaleFactor: 1.5,
                       ),
                    onPressed: () { 
                      
                      setState(() {
                      
                           //     if(_formKey.currentState.validate()){   
                            this.displayResult  = _calculateTotalReturn(); 
                  //  }
                          });
                    },
                  )
                  ),


                   Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,    
                    child: Text('Reset' , textScaleFactor: 1.5,),
                    onPressed: () {  
                      setState(() {
                        _reset();
                      });
                    },
                  )
                  ),


              ],))  ,

              Padding(
               padding: EdgeInsets.all(_minimumPadding*2),
               child: Text(this.displayResult, style: TextStyle(fontSize: 20),),
                )         

          ],
        )) ,
      ),
      
    );
  }
  Widget getImage() {   
    AssetImage assetImage = AssetImage('lib/images/money.jpg');
    Image image = Image(image: assetImage , width: 300.0, height: 200.0,);
    return Container( child: image , margin: EdgeInsets.all(35.0),);
  }


void _onDropDownItemSelected(newValueSelected) {
  setState(()   {   
    this._currentItemSelected = newValueSelected;
  });
}
String _calculateTotalReturn() {    
  double principal = double.parse(principalController.text);
  double roi = double.parse(roiController.text);
  double term = double.parse(termController.text);

  double totalAmountPayable = principal + (principal * roi * term) / 100;

  String result = 'After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
  return result;
}

void _reset() {   
  principalController.text = '';
  roiController.text  = '';
  termController.text = '';
  displayResult = '';
  _currentItemSelected = _currencies[0];
}

}