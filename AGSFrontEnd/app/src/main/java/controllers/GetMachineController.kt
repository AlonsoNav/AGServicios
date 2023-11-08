package controllers

import android.content.Context
import database.userDatabase

class GetMachineController {

    private val userDatabase= userDatabase()
    fun getMachineAttempt(serial: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="get_machine"
        val json =  """
        {
            "serial": "$serial"
        }
    """.trimIndent()
        val getMachineSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}