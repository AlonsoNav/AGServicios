package controllers

import android.content.Context
import database.userDatabase

class DeleteBrandController {
    private val userDatabase= userDatabase()
    fun deleteBrandAttempt(name: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="delete_brand"
        val json =  """
        {
            "name": "$name"
        }
    """.trimIndent()
        val deleteBrandSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}