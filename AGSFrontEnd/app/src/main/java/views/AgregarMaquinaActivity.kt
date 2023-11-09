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
import com.google.gson.JsonParser
import android.widget.TextView
import com.hytan.agserviciosv1.R
import controllers.AddMachineController
import controllers.GetBrandController
import controllers.GetMachineController
import controllers.GetTypeController

class AgregarMaquinaActivity : AppCompatActivity() {
    private val getTypeController = GetTypeController()
    private val getBrandController = GetBrandController()
    private val addMachineController = AddMachineController()
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_agregar_maquina)

        val volverAgregM = findViewById<Button>(R.id.buttonVolverAgregarMaquina)
        val AgregMaq = findViewById<Button>(R.id.buttonRegistrarMaquina)
        val itemsType = ArrayList<String>()
        val itemsBrand = ArrayList<String>()

        //Tipos
        val spinnerType = findViewById<Spinner>(R.id.spinnerTipoAgregar) // Replace with your Spinner ID
        val consultarType = getTypeController.getTypeAttempt("",this) { response ->
            val jsonString = response.body?.string()
            val jsonObject = JsonParser().parse(jsonString).asJsonObject
            if(response.isSuccessful){

                val typesArray = jsonObject.getAsJsonArray("types")
                for (i in 0 until typesArray.size()) {
                    val typeObject = typesArray.get(i)
                    val name = typeObject.asJsonObject.get("name").asString
                    val item = name.toString()
                    itemsType.add(item)
                }
                runOnUiThread{
                    val adapter = ArrayAdapter(this, R.layout.spinner_text_color, itemsType)
                    adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
                    spinnerType.adapter = adapter
                }
            }
        }

        //Consultar marca
        val spinnerBrand = findViewById<Spinner>(R.id.spinnerMarcaAgregar)
        val consultarBrand = getBrandController.getBrandAttempt("",this) { response ->
            val jsonString = response.body?.string()
            val jsonObject = JsonParser().parse(jsonString).asJsonObject
            if(response.isSuccessful){
                val brandArray = jsonObject.getAsJsonArray("brands")
                for (i in 0 until brandArray.size()) {
                    val typeObject = brandArray.get(i)
                    val name = typeObject.asJsonObject.get("name").asString
                    val item = name.toString()
                    itemsBrand.add(item)
                }
                runOnUiThread{
                    val adapter = ArrayAdapter(this, R.layout.spinner_text_color, itemsBrand)
                    adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item)
                    spinnerBrand.adapter = adapter
                }
            }
        }

        //pop up
        val dialog = Dialog(this)
        dialog.getWindow()?.setBackgroundDrawableResource(android.R.color.transparent);
        dialog.getWindow()?.getAttributes()?.windowAnimations = R.style.CustomDialogAnimation
        dialog.setContentView(R.layout.popupinformativo)
        dialog.setCancelable(true)



        volverAgregM.setOnClickListener{
            val volverAgregM = Intent(this,MenuGestionSistemaActivity::class.java)
            startActivity(volverAgregM)
            finish()
        }

        AgregMaq.setOnClickListener {
            val closeButton = dialog.findViewById<Button>(R.id.buttonListoPUP)
            val textViewPopup = dialog.findViewById<TextView>(R.id.textViewPUP)
            val editSerial = findViewById<EditText>(R.id.editSerialAgregarMaquina)
            val editModelo = findViewById<EditText>(R.id.editModeloAgregarMaquina)
            val serial = editSerial.text.toString()
            val model = editModelo.text.toString()
            val brandItem = spinnerBrand.selectedItem
            val typeItem = spinnerType.selectedItem
            var brand:String
            var type:String

            if(brandItem == null){
                brand = ""
            }else{
                brand = brandItem.toString()
            }

            if(typeItem == null){
                type = ""
            }else{
                type = typeItem.toString()
            }

            closeButton.setOnClickListener {
                dialog.dismiss()
            }
            val agregar = addMachineController.addMachineAttempt(brand,type,serial,model,this) { response ->
                val jsonString = response.body?.string()
                runOnUiThread{
                    val jsonObject = JsonParser().parse(jsonString).asJsonObject
                    textViewPopup.text = jsonObject.get("message").asString
                    dialog.show()
                }
            }
    }

        }
    }

