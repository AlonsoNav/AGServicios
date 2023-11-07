package controllers

import android.content.Context
import database.userDatabase

class DeleteTypeController {
    private val userDatabase= userDatabase()
    fun deleteTypeAttempt(name: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="delete_type"
        val json =  """
        {
            "name": "$name"
        }
    """.trimIndent()
        val deleteTypeSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}