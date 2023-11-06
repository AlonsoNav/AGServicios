package views

import android.app.Dialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import com.hytan.agserviciosv1.R

class MainMenuActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main_menu)

        val volver = findViewById<Button>(R.id.buttonVolverMM)
        val GS = findViewById<Button>(R.id.buttonGS)
        val PM = findViewById<Button>(R.id.buttonPM)
        val GI = findViewById<Button>(R.id.buttonGI)
        val RR = findViewById<Button>(R.id.buttonRR)

        //Pop up
        val dialog = Dialog(this)
        dialog.setContentView(R.layout.popupinformativo)
        dialog.setCancelable(true)
        dialog.getWindow()?.setBackgroundDrawableResource(android.R.color.transparent)
        dialog.getWindow()?.getAttributes()?.windowAnimations = R.style.CustomDialogAnimation

        volver.setOnClickListener{
            val volver = Intent(this,LoginActivity::class.java)
            startActivity(volver)
            finish()
        }

        GS.setOnClickListener{
            val GS = Intent(this,MenuGestionSistemaActivity::class.java)
            startActivity(GS)
            finish()
        }

        PM.setOnClickListener {
            enMantenimiento(dialog)
        }

        GI.setOnClickListener {
            enMantenimiento(dialog)
        }

        RR.setOnClickListener {
            enMantenimiento(dialog)
        }
    }
    fun enMantenimiento(dialog:Dialog) : Unit {
        val buttonClose = dialog.findViewById<Button>(R.id.buttonListoPUP)
        val textViewPopup = dialog.findViewById<TextView>(R.id.textViewPUP)

        textViewPopup.text = "Función en mantenimiento..."
        buttonClose.setOnClickListener {
            dialog.dismiss()
        }
        dialog.show()
    }
}