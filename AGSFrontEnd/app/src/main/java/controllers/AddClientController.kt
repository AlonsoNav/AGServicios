package controllers

import android.content.Context
import database.userDatabase

class AddClientController {
    private val userDatabase= userDatabase()
    fun addClientAttempt(name: String, number: Int, address: String, email: String, context: Context,
                         callback: (okhttp3.Response) -> Unit){
        val endpoint ="add_client"
        val json =  """
        {
            "name": "$name",
            "number": $number,
            "address": "$address",
            "email": "$email"
        }
    """.trimIndent()
        val addClientSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}