package controllers

import android.content.Context
import database.userDatabase

class UpdateTypeController {
    private val userDatabase= userDatabase()
    fun updateTypeAttempt(name: String, newName: String, description: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="update_type"
        val json =  """
        {
            "name": "$name",
            "newName": "$newName",
            "description": "$description"
        }
    """.trimIndent()
        val updateTypeSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}