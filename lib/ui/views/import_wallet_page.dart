import 'package:flutter/material.dart';
import 'package:kriptum/ui/shared/constants/app_spacings.dart';
import 'package:kriptum/ui/shared/widgets/title_app_bar.dart';

class ImportWalletPage extends StatelessWidget {
  const ImportWalletPage({super.key});

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
                  'Import from Secret Recovery Phrase',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24,),
                TextField(
                  
                  decoration: InputDecoration(
                    hintText: 'Enter your Secret Recovery Phrase',
                      label: Text('Secret Recovery Phrase'), border: OutlineInputBorder()),
                ),
                SizedBox(height: 24,),
                TextField(
                  
                  decoration: InputDecoration(
                    hintText: 'New Password',
                      label: Text('New Password'), border: OutlineInputBorder()),
                ),
                SizedBox(height: 24,),
                TextField(
                  
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                    helperText: 'Must be at least 8 characters',
                      label: Text('Confirm Password'), border: OutlineInputBorder()),
                ),
                SizedBox(height: 24,),
                ElevatedButton(
                    
                  onPressed: (){}, child: Text('IMPORT'))
            ],
          ),
        ),
      ),
    );
  }
}