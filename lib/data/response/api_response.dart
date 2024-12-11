
import 'status.dart';

class ApiResponse<T>{
  Status? status;
  T? data;
  String? message;

  // constructor
  ApiResponse(this.status, this.data,this.message);

  ApiResponse.loading(): status = Status.LOADING;

  ApiResponse.completed(this.data):status = Status.COMPLETED;

  ApiResponse.error(this.message): status = Status.ERROR;

  @override
  String toString() {
    // TODO: implement toString
    return 'Api Response: status=$status, data= $data, message=$message';
  }
}