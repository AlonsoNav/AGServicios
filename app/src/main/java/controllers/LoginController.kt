package controllers

import android.content.Context
import android.util.Log
import database.userDatabase
class LoginController {

    private val userDatabase=userDatabase()
    fun loginAttempt(username: String, password: String, context:Context){
        val loginSuccessful = userDatabase.postRequestToApi(username,password)
    }
}