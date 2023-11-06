package controllers

import android.content.Context
import database.userDatabase
class LoginController {

    private val userDatabase=userDatabase()
    fun loginAttempt(username: String, password: String, context:Context,callback: (okhttp3.Response) -> Unit){
        val loginSuccessful = userDatabase.postRequestToApi(username,password){ response ->
            callback(response)
        }


    }

}