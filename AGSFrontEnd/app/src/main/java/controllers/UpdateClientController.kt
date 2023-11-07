package controllers

import android.content.Context
import database.userDatabase

class UpdateClientController {
    private val userDatabase= userDatabase()
    fun updateBrandAttempt(name: String, newName: String, description: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="update_client"
        val json =  """
        {
            "name": "$name",
            "newName": "$newName",
            "description": "$description"
        }
    """.trimIndent()
        val updateBrandSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}