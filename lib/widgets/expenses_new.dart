

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app2/models/expens.dart';

class ExpeneseNew extends StatefulWidget {
  const ExpeneseNew({super.key,required this.expensedata});
  final void Function(Expense expense) expensedata;

  @override
  State<ExpeneseNew> createState() {
    return _ExpenseNewState();
  }
}

class _ExpenseNewState extends State<ExpeneseNew> {
  final _tiltlecontroller = TextEditingController();
  final _valuecontroller = TextEditingController();
  DateTime? _selecteddate;
  Category _selectedcatgory = Category.leisure;

  void _presentdatapicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);
    setState(() {
      _selecteddate = pickeddate;
    });
  }
  void _showsystem(){
    // 3shan tb2a nfs shkl el iphone
    if(Platform.isIOS){
    showCupertinoDialog(context: context, builder: (ctx)=>
      AlertDialog(
        title: const Text('input invalid'),
        content:const Text('please make sure a valid tilt , amount ,date and category was entered'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child:const  Text('ok'))
        ],
      ),);}
      else{
         showDialog(context: context, builder: (ctx) =>
      AlertDialog(
        title: const Text('input invalid'),
        content:const Text('please make sure a valid tilt , amount ,date and category was entered'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child:const  Text('ok'))
        ],
      ),);
      }

  }
  void _submitedExpensesdata(){
   final enteredamount=double.tryParse(_valuecontroller.text);
  final amountisvalid= enteredamount== null || enteredamount <=0;

    if(_tiltlecontroller.text.trim().isEmpty || amountisvalid||_selecteddate==null){
      
      
      _showsystem();
      return ;

    }
   
      widget.expensedata(Expense(title: _tiltlecontroller.text, amount: enteredamount, date: _selecteddate!, category: _selectedcatgory));
    
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _tiltlecontroller.dispose();
    _valuecontroller.dispose();
    super.dispose();
    //msh btsht8l 8er stateful
  }

  @override
  Widget build(BuildContext context) {
   final keyboardspace =MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx,constrains){
      final width=constrains.maxWidth;

      return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.fromLTRB(16, 16, 16, 16+ keyboardspace),
          child: Column(
            children: [
              if(width>=600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start
                ,children: [
                
               Expanded(child: TextField(
                controller: _tiltlecontroller,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('title'),
                ),
              ),), 
             const  SizedBox(width: 24,),
             Expanded(
                    child: TextField(
                      maxLength: 10,
                      controller: _valuecontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('enter your amount '),
                      ),
                    ),
                  ),

              ],)
              else

              
              TextField(
                controller: _tiltlecontroller,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('title'),
                ),
              ),
              if(width>=600)
              Row(children: [
                DropdownButton(
                    value: _selectedcatgory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          
                        _selectedcatgory=value!;
                        // 3shan mtb2ash null 
                        });
                      }),
                       
                  const SizedBox(width: 24,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selecteddate == null
                            ? 'no date'
                            : formatter.format(_selecteddate!)),
                        IconButton(
                            onPressed: _presentdatapicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  ),

              ],)
              else
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLength: 10,
                      controller: _valuecontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('enter your amount '),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selecteddate == null
                            ? 'no date'
                            : formatter.format(_selecteddate!)),
                        IconButton(
                            onPressed: _presentdatapicker,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  ),
                ],
              ),
             const  SizedBox(height: 16,),
             if(width>=600)
             Row(children: [
              const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('canel'),
                  ),
                  ElevatedButton(
                    onPressed:_submitedExpensesdata,
                    child: const Text('Save Expense'),
                  ),
             ],)
             else
              Row(
                children: [
                  DropdownButton(
                    value: _selectedcatgory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          
                        _selectedcatgory=value!;
                        // 3shan mtb2ash null 
                        });
                      }),
                       const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('canel'),
                  ),
                  ElevatedButton(
                    onPressed:_submitedExpensesdata,
                    child: const Text('Save Expense'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
     
    },
    );
    
  }
}
