package controllers

import android.content.Context
import database.userDatabase

class GetClientController {
    private val userDatabase= userDatabase()
    fun getClientAttempt(name: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="get_client"
        val json =  """
        {
            "name": "$name"
        }
    """.trimIndent()
        val getClientSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}