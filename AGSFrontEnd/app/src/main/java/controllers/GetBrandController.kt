package controllers

import android.content.Context
import database.userDatabase

class GetBrandController {
    private val userDatabase= userDatabase()
    fun getBrandAttempt(name: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="get_brand"
        val json =  """
        {
            "name": "$name"
        }
    """.trimIndent()
        val getBrandSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}