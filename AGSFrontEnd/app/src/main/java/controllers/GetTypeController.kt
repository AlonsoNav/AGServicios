package controllers

import android.content.Context
import database.userDatabase

class GetTypeController {
    private val userDatabase= userDatabase()
    fun getTypeAttempt(name: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="get_type"
        val json =  """
        {
            "name": "$name"
        }
    """.trimIndent()
        val getTypeSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}