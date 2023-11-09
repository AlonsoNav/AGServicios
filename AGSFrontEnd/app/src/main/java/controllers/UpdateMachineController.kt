package controllers

import android.content.Context
import database.userDatabase

class UpdateMachineController {
    private val userDatabase= userDatabase()
    fun updateMachineAttempt(serial: String, newSerial: String, model: String, context: Context, callback: (okhttp3.Response) -> Unit){
        val endpoint ="update_machine"
        val json =  """
        {
            "serial": "$serial",
            "newSerial": "$newSerial",
            "model": "$model"
        }
    """.trimIndent()
        val updateMachineSuccessful = userDatabase.postRequestToApi(json,endpoint) { response ->
            callback(response)
        }
    }
}