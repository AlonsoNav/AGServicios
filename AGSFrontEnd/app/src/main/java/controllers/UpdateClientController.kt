package controllers

import android.content.Context
import database.userDatabase

class UpdateClientController {
    private val userDatabase= userDatabase()
    fun updateBrandAttempt(name: String, newName: String, number: Int, address: String, email: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="update_client"
        val json =  """
        {
            "name": "$name",
            "newName": "$newName",
            "number": $number,
            "address": "$address",
            "email": "$email"
        }
    """.trimIndent()
        val updateBrandSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}