package views


import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.Button
import android.widget.EditText
import android.widget.ListView
import android.widget.Spinner
import android.widget.TextView
import com.google.gson.JsonParser
import com.hytan.agserviciosv1.R
import controllers.GetMachineController

class ConsultarMaquinaActivity : AppCompatActivity() {
    private val getMachineController = GetMachineController()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_consultar_maquina)

        val volverCM = findViewById<Button>(R.id.buttonVolverConsultarMaquina)
        val consultar = findViewById<Button>(R.id.buttonConsultarMaquina)
        val serialText = findViewById<EditText>(R.id.editSerialConsultarMaquina)

        val dialogD = Dialog(this)
        dialogD.setContentView(R.layout.popup_display)
        dialogD.setCancelable(true)
        dialogD.getWindow()
            ?.setBackgroundDrawableResource(android.R.color.transparent);
        dialogD.getWindow()?.getAttributes()?.windowAnimations =
            R.style.CustomDialogAnimation

        val dialog = Dialog(this)
        dialog.getWindow()
            ?.setBackgroundDrawableResource(android.R.color.transparent);
        dialog.getWindow()?.getAttributes()?.windowAnimations =
            R.style.CustomDialogAnimation
        dialog.setContentView(R.layout.popupinformativo)
        dialog.setCancelable(true)

        volverCM.setOnClickListener{

            val volverCM = Intent(this, MenuGestionSistemaActivity::class.java)
            startActivity(volverCM)
            finish()
        }

        consultar.setOnClickListener {
            val serial = serialText.text.toString()
            val consultar = getMachineController.getMachineAttempt(serial,this) { response ->
                val jsonString = response.body?.string()
                val jsonObject = JsonParser().parse(jsonString).asJsonObject
                if(response.isSuccessful){
                    val listo = dialogD.findViewById<Button>(R.id.buttonListoPUPDisplay)
                    val textDisplay = dialogD.findViewById<TextView>(R.id.textViewPUPDisplay)
                    val lista = dialogD.findViewById<ListView>(R.id.listViewDisplay)
                    val items = ArrayList<String>()
                    textDisplay.text="Lista de máquina"
                    listo.setOnClickListener {
                        dialogD.dismiss()
                    }
                    val machinesArray = jsonObject.getAsJsonArray("machines")
                    for (i in 0 until machinesArray.size()) {
                        val typeObject = machinesArray.get(i)
                        val serial = typeObject.asJsonObject.get("serial")
                        val model = typeObject.asJsonObject.get("model")
                        val brand = typeObject.asJsonObject.get("brand")
                        val type = typeObject.asJsonObject.get("type")
                        val item = "Serial: $serial\nModelo: $model\nMarca: $brand\nTipo: $type"
                        items.add(item)
                    }
                    runOnUiThread{
                        val adapter = ArrayAdapter(this, R.layout.list_text_color, items)
                        lista.adapter = adapter
                        dialogD.show()
                    }
                }else{
                    val closeButton = dialog.findViewById<Button>(R.id.buttonListoPUP)
                    val textViewPopup = dialog.findViewById<TextView>(R.id.textViewPUP)
                    closeButton.setOnClickListener {
                        dialog.dismiss()
                    }
                    runOnUiThread{
                        textViewPopup.text = jsonObject.get("message").asString
                        dialog.show()
                    }
                }
            }
        }
    }
}