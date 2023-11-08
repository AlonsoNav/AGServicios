package controllers

import android.content.Context
import database.userDatabase

class AddBrandController {
    private val userDatabase= userDatabase()
    fun addBrandAttempt(name: String, description: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="add_brand"
        val json =  """
        {
            "name": "$name",
            "description": "$description"
        }
    """.trimIndent()
        val addBrandSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}