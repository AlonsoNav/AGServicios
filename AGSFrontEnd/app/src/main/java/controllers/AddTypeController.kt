package controllers

import android.content.Context
import database.userDatabase

class AddTypeController {
    private val userDatabase= userDatabase()
    fun addTypeAttempt(name: String, description: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="add_type"
        val json =  """
        {
            "name": "$name",
            "description": "$description"
        }
    """.trimIndent()
        val addTypeSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}