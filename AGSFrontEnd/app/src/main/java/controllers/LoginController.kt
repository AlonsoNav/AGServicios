package controllers

import android.content.Context
import android.util.Log
import database.userDatabase
class LoginController {

    private val userDatabase=userDatabase()
    var code=0
    var message:String? =""
    fun loginAttempt(username: String, password: String, context:Context,callback: (Pair<Int, String?>) -> Unit){
        val loginSuccessful = userDatabase.postRequestToApi(username,password){ response ->
            code = response.code
            message =response.body?.string()
            callback(Pair(code,message))
        }


    }

}