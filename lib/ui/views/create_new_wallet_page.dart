import 'package:flutter/material.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/title_app_bar.dart';

class CreateNewWalletPage extends StatelessWidget {
  const CreateNewWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTitleAppBar(),
      body:  Padding(
        padding: AppSpacings.horizontalPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'This password will unlock your Kriptum wallet only on this device',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                    label: Text('New Password'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 24,
              ),
              TextField(
                
                obscureText: true,
                decoration: InputDecoration(
                  helperText: 'Must be at leaset 8 characters',
                    label: Text('Confirm Password'), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  
                onPressed: (){}, child: Text('Create password'))
            ],
          ),
        ),
      ),
    );
  }
}
