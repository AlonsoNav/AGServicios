package controllers

import android.content.Context
import database.userDatabase

class DeleteMachineController {

    private val userDatabase= userDatabase()
    fun deleteMachineAttempt(serial: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="delete_machine"
        val json =  """
        {
            "serial": "$serial"
        }
    """.trimIndent()
        val deleteMachineSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}