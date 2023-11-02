package controllers

import android.content.Context
import android.util.Log
import database.userDatabase
class LoginController {

    private val userDatabase=userDatabase()
    fun loginAttempt(username: String, password: String, context:Context):Pair<Int,String>{
        val loginSuccessful = userDatabase.postRequestToApi(username,password)
        val code=userDatabase.getResponseCode()
        val mensaje=userDatabase.getResponsebody()
        return Pair(code,mensaje)
    }
}