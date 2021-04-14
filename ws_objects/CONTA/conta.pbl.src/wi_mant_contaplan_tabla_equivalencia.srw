$PBExportHeader$wi_mant_contaplan_tabla_equivalencia.srw
forward
global type wi_mant_contaplan_tabla_equivalencia from wi_mvent_con_empresa
end type
type uo_ejercicio from u_ejercicio within wi_mant_contaplan_tabla_equivalencia
end type
type pb_imprimir_preli from picturebutton within wi_mant_contaplan_tabla_equivalencia
end type
type pb_1 from picturebutton within wi_mant_contaplan_tabla_equivalencia
end type
end forward

global type wi_mant_contaplan_tabla_equivalencia from wi_mvent_con_empresa
integer width = 3442
integer height = 1864
uo_ejercicio uo_ejercicio
pb_imprimir_preli pb_imprimir_preli
pb_1 pb_1
end type
global wi_mant_contaplan_tabla_equivalencia wi_mant_contaplan_tabla_equivalencia

type variables

end variables

forward prototypes
public subroutine f_cargar_contaplan (ref datawindow adw_data, string as_empresa, integer ai_ejercicio)
end prototypes

public subroutine f_cargar_contaplan (ref datawindow adw_data, string as_empresa, integer ai_ejercicio);Long				i,j, ll_cont
String			ls_sql,ls_cuenta_equiv,ls_titulo_equiv,ls_cuenta_vieja
DataStore 		lds_contaplan


ls_sql = "SELECT contaplan.ejercicio, contaplan.empresa,contaplan.cuenta, " + &
			" contaplan.titulo,contaplan.analitica, contaplan.tipocta, " + &
			" contaplan.directos, contaplan.nivel, contaplan.coste " + &
			" FROM   contaplan " +&
				" WHERE contaplan.ejercicio = " + String(ai_ejercicio)  + &
				" AND contaplan.empresa = '" + as_empresa + "'" +&
				" ORDER BY contaplan.ejercicio,contaplan.empresa, contaplan.cuenta"

lds_contaplan = f_cargar_cursor(ls_sql)


ll_cont = lds_contaplan.RowCount()
IF ll_cont > 0 THEN
	
	FOR i = 1 TO ll_cont
		j = adw_data.InsertRow(0)
		adw_data.Object.ejercicio[j]     = ai_ejercicio
		adw_data.Object.empresa[j]	      = as_empresa
		adw_data.Object.cuenta_vieja[j]	= lds_contaplan.object.cuenta[i]
		adw_data.Object.titulo_viejo[j]	= lds_contaplan.object.titulo[i]
		adw_data.Object.analitica[j]		= lds_contaplan.object.analitica[i]	
		adw_data.Object.tipocta[j]		   = lds_contaplan.object.tipocta[i]	
		adw_data.Object.directos[j]	   = lds_contaplan.object.directos[i]	
		adw_data.Object.nivel[j]		   = lds_contaplan.object.nivel[i]	
		adw_data.Object.coste[j]		   = lds_contaplan.object.coste[i]
		
		ls_cuenta_vieja = lds_contaplan.object.cuenta[i]
		
		/// Añadimos equivalencias
		SELECT contaplan_tabla_equivalencia.cuenta_equiv, 
			    contaplan_tabla_equivalencia.titulo_equiv
				 into :ls_cuenta_equiv,:ls_titulo_equiv
			 FROM   contaplan_tabla_equivalencia
			 where  contaplan_tabla_equivalencia.cuenta_vieja = :ls_cuenta_vieja
			  using sqlca;
			 
			 if sqlca.sqlcode = 0 then
				
				adw_data.Object.cuenta_equiv[j]	= ls_cuenta_equiv
				adw_data.Object.titulo_equiv[j]  = ls_titulo_equiv
				
				
			end if
	NEXT
	
	Destroy(lds_contaplan)

	adw_data.SetFocus()
	adw_data.SetRow(1)
	adw_data.SetColumn("cuenta_equiv")
//	Return ll_cont
ELSE
	Destroy(lds_contaplan)
//	Messagebox("ERROR","No hay materias para los datos indicados !")
//	Return 0
END IF


end subroutine

event open;call super::open;if not (f_control_usuario_contabilidad(nombre_usuario)) then
	messagebox ('Violacion de seguridad','No se tiene acceso a la zona restringida')
	close(this)
else
//
   istr_parametros.s_titulo_ventana  = "Mantenimiento de tabla de equivalencia "
//	istr_parametros.s_listado         = "report_contaplan_tabla_equivalencia"
   This.title = istr_parametros.s_titulo_ventana
	tipo_mantenimiento = "C"
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
        dw_1.Retrieve(sle_valor.Text,Dec(uo_ejercicio.em_ejercicio.text))
      END IF
   END IF

//	f_mascara_columna(dw_1,"asientoinicial","###,##0")
	
end if
//cb_borrar.enabled    =  true
//cb_insertar.enabled  =  true


sle_valor.text = "1"
dw_1.Retrieve()
end event

event ue_inserta_fila;call super::ue_inserta_fila;// dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
// dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo
Dec ejer
ejer          = Dec(uo_ejercicio.em_ejercicio.text)


titulo        =  This.title
longitud      =  len(trim(string(ejer)))
criterio[2]   =  trim(string(ejer))+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[1]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "contaplan_tabla_equivalencia"



dw_1.Retrieve()

//if dw_1.rowcount( )<= 0 then
//	/// recuperar cuenta contable
//	/// añadirselo a la de equivalencia
//	dw_1.setredraw(false)
//	 // Función que nos carga el plan contable de la empresa
//	 // que se seleccione y las equivalencias correspondientes
//	 f_cargar_contaplan(dw_1,sle_valor.text,ejer)
//	
//	dw_1.setredraw(true)
//end if

CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;//pb_calculadora.visible = TRUE
end event

on wi_mant_contaplan_tabla_equivalencia.create
int iCurrent
call super::create
this.uo_ejercicio=create uo_ejercicio
this.pb_imprimir_preli=create pb_imprimir_preli
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_ejercicio
this.Control[iCurrent+2]=this.pb_imprimir_preli
this.Control[iCurrent+3]=this.pb_1
end on

on wi_mant_contaplan_tabla_equivalencia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_ejercicio)
destroy(this.pb_imprimir_preli)
destroy(this.pb_1)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;//pb_calculadora.visible = FALSE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contaplan_tabla_equivalencia
integer x = 37
integer y = 320
integer width = 3218
integer height = 1280
string dataobject = "dw_contaplan_tabla_equivalencia"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::sqlpreview;call super::sqlpreview;//messagebox("AL",sqlsyntax)
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contaplan_tabla_equivalencia
boolean visible = false
integer x = 50
integer width = 283
string text = "Empresa:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contaplan_tabla_equivalencia
integer x = 2267
integer y = 224
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contaplan_tabla_equivalencia
boolean visible = false
integer x = 1719
integer y = 128
boolean enabled = false
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contaplan_tabla_equivalencia
boolean visible = false
integer x = 352
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_empresa"
ue_titulo      = "AYUDA SELECCION DE EMPRESAS CONTABLES"
ue_filtro      =""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contaplan_tabla_equivalencia
integer x = 2706
integer y = 224
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contaplan_tabla_equivalencia
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contaplan_tabla_equivalencia
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contaplan_tabla_equivalencia
integer width = 2834
end type

type uo_ejercicio from u_ejercicio within wi_mant_contaplan_tabla_equivalencia
boolean visible = false
integer x = 2597
integer y = 224
integer width = 622
integer height = 352
integer taborder = 40
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type pb_imprimir_preli from picturebutton within wi_mant_contaplan_tabla_equivalencia
boolean visible = false
integer x = 3141
integer y = 220
integer width = 105
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;//dw_1.RowsCopy(dw_1.GetRow(),dw_1.RowCount(), Primary!, dw_listado, 1, Primary!)
////dw_listado.retrieve(Dec(ejercicio.em_ejercicio.text),codigo_empresa,niv1,niv2,cta1,cta2)
//f_imprimir_datawindow(dw_listado)
//dw_listado.reset()
end event

type pb_1 from picturebutton within wi_mant_contaplan_tabla_equivalencia
integer x = 2121
integer y = 220
integer width = 105
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Export5!"
alignment htextalign = left!
end type

event clicked;// Preparar Dw para importar excel.
integer li_opcion
li_opcion = MessageBox("Proceso Importación Tabla de Equivalencia","Desea Importar Tabla de Equivalencia",Question!,YesNo!,2)
	
if li_opcion = 1 then
			
	DELETE from contaplan_tabla_equivalencia
	using sqlca;

	
	
	 dw_1.Reset()
	 
	 // Importar de Excel a Una Dw
	OLEObject excel 
	Integer li_RetValue, li_rtn 
	Boolean lb_sheet_rtn
	Boolean lb_exist , lb_exist_base
	Long ll_cnt
	Long        li_rc , ll_rc
	String      ls_path_excel
	String       ls_new_excel
	
	
	// Genero  Nuevo
	ls_new_excel  = "C:\contaplan_tabla_equivalencia_new.xls"
	ls_path_excel  ="C:\contaplan_tabla_equivalencia.xls"
	
	 lb_exist_base = FileExists(ls_path_excel)
	
	  If lb_exist_base = False Then
	MessageBox("Importación","" + "No se encuentra la tabla de eqivalencias : " +  ls_path_excel)
	else
	
	// Chek de Existencia para Borrarlo
	lb_exist = FileExists(ls_new_excel)
	IF lb_exist Then FileDelete(ls_new_excel)
	
	 st_1.Text ="Creando Conecxión a Excel"  
	 
	// Crear Objeto
	Excel = create OLEObject 
	
	//Conectar a Excel
	li_rtn = excel.ConnectToNewObject("excel.application") 
	IF li_rtn <> 0 THEN 
			MessageBox('Excel error','No puede conectarse a Excel') 
		DESTROY excel 
		RETURN 0 
	 END IF 
	 
	  
	 //Abrir excel
	excel.WorkBooks.Open( ls_path_excel ) 
	excel.Application.Visible = False
	excel.windowstate   = 2  // Estados 1 : Normal, 2 : Minimize, 3 : Maximize 
	//Seleccionar un rango y eliminarlo
	st_1.Text ="Creando Nuevo Excel"  
	 lb_sheet_rtn = excel.worksheets(1).Activate
		excel.Worksheets(1).Range("A1:E1").Delete
	 excel.application.workbooks(1).saveas(ls_new_excel,-4143) 
	 //Seleccionar todo lo activo y copiarlo al CLip
	 excel.ActiveCell.CurrentRegion.Select()  
	 excel.Selection.Copy()
	 st_1.Text ="Importando Excel"  
	 //Importar desde el Clipboard
	 ll_rc = dw_1.ImportClipBoard (1) 
	 ClipBoard('') 
	 excel.Application.Quit
	 excel.disconnectobject() 
	 DESTROY excel 
	end if
	
	
	dw_1.setsort("orden A")
	dw_1.sort()
	
	dw_1.AcceptText()
	
	IF dw_1.Update() = 1 THEN 
		COMMIT using sqlca;
	ELSE		
		ROLLBACK using sqlca;
	END IF

	
end if

end event

