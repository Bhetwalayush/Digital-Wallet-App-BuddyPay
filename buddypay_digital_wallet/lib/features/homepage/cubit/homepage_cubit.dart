// import 'package:bloc/bloc.dart';
// import 'package:buddypay_digital_wallet/viewmodels/bloc/login/login_bloc.dart';
// import 'package:buddypay_digital_wallet/viewmodels/bloc/signup/signup_bloc.dart';
// import 'package:meta/meta.dart';

// part 'homepage_state.dart';


  
// class DashboardCubit extends Cubit<void> {
//   DashboardCubit(
//     this._signupBloc,
//     this._loginBloc,
//   ) : super(null);


//   final SignupBloc _signupBloc;
//   final LoginBloc _loginBloc;


//   void openArithmeticBlocView(BuildContext context) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => BlocProvider.value(
//                   value: _arithmeticBloc,
//                   child: ArithmeticBlocView(),
//                 )));
//   }

//   void openStudentBlocView(BuildContext context) {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => BlocProvider.value(
//                   value: _studenyBloc,
//                   child: StudentBlocView(),
//                 )));
//   }
// }

