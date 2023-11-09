package controllers

import android.content.Context
import database.userDatabase

class DeleteClientController {
    private val userDatabase= userDatabase()
    fun deleteClientAttempt(name: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="delete_client"
        val json =  """
        {
            "name": "$name"
        }
    """.trimIndent()
        val deleteClientSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}