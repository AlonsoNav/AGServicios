package controllers

import android.content.Context
import database.userDatabase
class LoginController {

    private val userDatabase=userDatabase()
    fun loginAttempt(username: String, password: String, context:Context,callback: (okhttp3.Response) -> Unit){
        val endpoint ="login"
        val json =  """
        {
            "username": "$username",
            "password": "$password"
        }
    """.trimIndent()
        val loginSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}