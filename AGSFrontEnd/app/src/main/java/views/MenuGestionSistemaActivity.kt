package views

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.ImageButton
import com.hytan.agserviciosv1.R

class MenuGestionSistemaActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_menu_gestion_sistema)

        //Volver
        val volverGM = findViewById<Button>(R.id.buttonVolverGM)

        //Gestión de máquinas
        val eliminarGM = findViewById<ImageButton>(R.id.borrarMaquina)
        val registrarGM = findViewById<ImageButton>(R.id.agregarMaquina)
        val consultarGM = findViewById<ImageButton>(R.id.consultarMaquina)
        val editarGM = findViewById<ImageButton>(R.id.editarMaquina)

        //Gestión de marcas
        val eliminarGMAR = findViewById<ImageButton>(R.id.borrarMaquina)
        val registrarGMAR = findViewById<ImageButton>(R.id.agregarMaquina)
        val consultarGMAR = findViewById<ImageButton>(R.id.consultarMaquina)
        val editarGMAR = findViewById<ImageButton>(R.id.editarMaquina)

        // Gestión de maquinaria
        val agregarGTDM = findViewById<ImageButton>(R.id.agregarMaquinaria)
        val consultarGTDM = findViewById<ImageButton>(R.id.consultarMaquinaria)
        val editarGTDM = findViewById<ImageButton>(R.id.editarMaquinaria)
        val eliminarGTDM = findViewById<ImageButton>(R.id.borrarMaquinaria)

        // Gestión de clientes
        val eliminarGC = findViewById<ImageButton>(R.id.borrarClientes)
        val registarGC = findViewById<ImageButton>(R.id.agregarClientes)
        val consultarGC = findViewById<ImageButton>(R.id.consultarClientes)
        val editarGC = findViewById<ImageButton>(R.id.editarClientes)

        //Listeners

        //Volver
        volverGM.setOnClickListener{
            val volverMM = Intent(this,MainMenuActivity::class.java)
            startActivity(volverMM)
            finish()
        }

        //Gestión de máquinas
        eliminarGM.setOnClickListener{
            val eliminarGM = Intent(this, EliminarMaquinaActivity::class.java)
            startActivity(eliminarGM)
            finish()
        }

        registrarGM.setOnClickListener {
            val registrarGM = Intent(this, AgregarMaquinaActivity::class.java)
            startActivity(registrarGM)
            finish()
        }

        consultarGM.setOnClickListener {
            val consultarGM = Intent(this, ConsultarMaquinaActivity::class.java)
            startActivity(consultarGM)
            finish()
        }

        editarGM.setOnClickListener {
            val editarGM = Intent(this, EditarMaquinaActivity::class.java)
            startActivity(editarGM)
            finish()
        }

        //Gestión de marcas
        eliminarGM.setOnClickListener{
            val eliminarGMAR = Intent(this, EliminarMarcaActivity::class.java)
            startActivity(eliminarGMAR)
            finish()
        }

        registrarGM.setOnClickListener {
            val registrarGMAR = Intent(this, AgregarMarcaActivity::class.java)
            startActivity(registrarGMAR)
            finish()
        }

        consultarGM.setOnClickListener {
            val consultarGMAR = Intent(this, ConsultarMarcaActivity::class.java)
            startActivity(consultarGMAR)
            finish()
        }

        editarGM.setOnClickListener {
            val editarGMAR = Intent(this, EditarMarcaActivity::class.java)
            startActivity(editarGMAR)
            finish()
        }

        //Gestión de maquinaria
        agregarGTDM.setOnClickListener {
            val agregarGTDM = Intent(this, AgregarTipoDeMaquinariaActivity::class.java)
            startActivity(agregarGTDM)
            finish()
        }

        consultarGTDM.setOnClickListener {
            val consultarGTDM = Intent(this, ConsultarTipoDeMaquinariaActivity::class.java)
            startActivity(consultarGTDM)
            finish()
        }

        editarGTDM.setOnClickListener {
            val editarGTDM = Intent(this, EditarTipoDeMaquinariaActivity::class.java)
            startActivity(editarGTDM)
            finish()
        }

        eliminarGTDM.setOnClickListener {
            val eliminarGTDM = Intent(this, EliminarTipoDeMaquinariaActivity::class.java)
            startActivity(eliminarGTDM)
            finish()
        }

        //Gestión de clientes
        eliminarGC.setOnClickListener {
            val eliminarGC = Intent(this, EliminarClienteActivity::class.java)
            startActivity(eliminarGC)
            finish()
        }

        registarGC.setOnClickListener {
            val registrarGC = Intent(this, AgregarClienteActivity::class.java)
            startActivity(registrarGC)
            finish()
        }

        consultarGC.setOnClickListener{
            val consultarGC = Intent(this, ConsultarClienteActivity::class.java)
            startActivity(consultarGC)
            finish()
        }


    }

}