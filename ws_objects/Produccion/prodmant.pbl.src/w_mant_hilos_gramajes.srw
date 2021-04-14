$PBExportHeader$w_mant_hilos_gramajes.srw
forward
global type w_mant_hilos_gramajes from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_hilos_gramajes
end type
type dw_2 from datawindow within w_mant_hilos_gramajes
end type
type cb_1 from commandbutton within w_mant_hilos_gramajes
end type
end forward

global type w_mant_hilos_gramajes from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2990
integer height = 2640
pb_calculadora pb_calculadora
dw_2 dw_2
cb_1 cb_1
end type
global w_mant_hilos_gramajes w_mant_hilos_gramajes

type variables

end variables

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event open;call super::open;integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
		This.pb_calculadora.visible = false;		
end choose

istr_parametros.s_titulo_ventana  = "Mantenimiento de Gramajes por hilos"

This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
		
	END IF
END IF
dw_2.SetTransObject(SQLCA)
dw_2.retrieve (codigo_empresa)


	
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"hilos",dec(sle_valor.text))

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(string(sle_valor.text)))
criterio[2]   =  trim(string(sle_valor.text))+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "prodhilosgramaje"

dw_1.Retrieve(codigo_empresa,dec(sle_valor.Text))

dw_2.retrieve (codigo_empresa)

CALL Super::ue_recuperar
end event

on w_mant_hilos_gramajes.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_2=create dw_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_1
end on

on w_mant_hilos_gramajes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_2)
destroy(this.cb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_hilos_gramajes
integer x = 32
integer y = 272
integer width = 2464
integer height = 164
string dataobject = "dw_hilos_gramajes"
end type

event dw_1::rbuttondown;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "molde"
	bus_titulo     = "VENTANA SELECCION MOLDES "
	bus_datawindow = "dw_ayuda_prodmoldes"
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown
end event

event dw_1::key;valor_empresa = TRUE	
bus_filtro=""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
CASE "molde"
	bus_titulo     = "VENTANA SELECCION MOLDES "
	bus_datawindow = "dw_ayuda_prodmoldes"
CASE ELSE
	SetNull(bus_campo)
END CHOOSE
CALL Super::Key


end event

event dw_1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_prodplatos"
CHOOSE CASE f_objeto_datawindow(this)
CASE 'pb_molde'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"molde")
   OpenWithParm(wi_mant_prodmoldes,lstr_param)  
END CHOOSE
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_hilos_gramajes
integer x = 69
integer y = 144
integer width = 270
string text = "Hilos:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_hilos_gramajes
integer x = 2537
integer y = 212
end type

event cb_insertar::clicked;String descrip

//if this.enabled then
//	descrip = dw_1.object.descripcion[dw_1.GetRow()]
//	if IsNull(descrip) or Trim(descrip) = "" then
//		f_mensaje("Guardar datos de la Aplicación","Ha de introducir la descripción del plato")
//		dw_1.SetFocus()
//		return
//	end if
//end if
Call super::clicked



end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_hilos_gramajes
integer x = 2537
integer y = 308
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_hilos_gramajes
integer x = 370
integer y = 140
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodhilos"
ue_titulo      = "AYUDA GRAMAJES POR HILAJE"
ue_filtro      =""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_hilos_gramajes
integer x = 2537
integer y = 404
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_hilos_gramajes
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_hilos_gramajes
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_hilos_gramajes
integer width = 2930
end type

type pb_calculadora from u_calculadora within w_mant_hilos_gramajes
integer x = 635
integer y = 136
integer width = 114
integer height = 100
integer taborder = 0
boolean originalsize = false
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select   count(*) 
 Into       :registros
 From     prodhilosgramaje
 Where  prodhilosgramaje.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,prodhilosgramaje.hilos)+1)
  Into     :sle_valor.text
  From   prodhilosgramaje
  Where  prodhilosgramaje.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

type dw_2 from datawindow within w_mant_hilos_gramajes
integer x = 50
integer y = 528
integer width = 2848
integer height = 1720
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_tabla_gramajes_hilos"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_1 from commandbutton within w_mant_hilos_gramajes
integer x = 955
integer y = 2288
integer width = 951
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar Pasos y Gramajes"
end type

event clicked;string sel, articulo, ver, operacion, contadoraplicacion
datastore datos
long i, total_regs
dec paso_cliche, numero_hilos, gramaje, ancho, largo, gram_cm2, coste_mp_operacion

if MessageBox("Quieto","Sólo toca este botón si sabes lo que hace. ¿ Continuar ? ", Exclamation!, YesNo!, 2) = 1 then
	sel = " select art_ver_op_aplicaciones.articulo, art_ver_op_aplicaciones.version, art_ver_op_aplicaciones.operacion, "+&
			" art_ver_op_aplicaciones.contadoraplicacion, prodpantallas.paso_cliche, prodhilosgramaje.gram_cm2, "+&
			" formatos.ancho, formatos.largo "+&
			" from art_ver_op_aplicaciones, prodpantallas, art_Ver_operaciones, formatos, prodhilosgramaje "+&
			" where art_ver_op_aplicaciones.empresa = '"+codigo_empresa+"' "+&
			" and art_ver_op_aplicaciones.empresa = prodpantallas.empresa "+&
			" and art_ver_op_aplicaciones.pantalla = prodpantallas.codigo "+&
			" and art_ver_op_aplicaciones.empresa = art_ver_operaciones.empresa "+&
			" and art_ver_op_aplicaciones.articulo = art_ver_operaciones.articulo "+&
			" and art_ver_op_aplicaciones.version = art_ver_operaciones.version "+&
			" and art_ver_op_aplicaciones.operacion = art_ver_operaciones.operacion "+&
			" and art_ver_operaciones.empresa = formatos.empresa "+&
			" and art_ver_operaciones.formato = formatos.codigo "+&
			" and prodpantallas.empresa = prodhilosgramaje.empresa "+&
			" and prodpantallas.numero_hilos = prodhilosgramaje.hilos "+&
			" and ( art_ver_op_aplicaciones.tipoaplicacion = '4' or art_ver_op_aplicaciones.tipoaplicacion = '26' ) "  // Ser. Tensada y Destensada
			
	f_cargar_cursor_nuevo ( sel, datos)
	
	total_regs = datos.rowcount()
	connect using SQLCA;
	for i = 1 to total_regs
		articulo = datos.object.art_ver_op_aplicaciones_articulo[i]
		ver = datos.object.art_ver_op_aplicaciones_version[i]
		operacion = datos.object.art_ver_op_aplicaciones_operacion[i]
		contadoraplicacion = datos.object.art_ver_op_aplicaciones_contadoraplicacion[i]
		gram_cm2 = datos.object.prodhilosgramaje_gram_cm2[i]
		paso_cliche = datos.object.prodpantallas_paso_cliche[i]	
		ancho = datos.object.formatos_ancho[i]
		largo = datos.object.formatos_largo[i]
	
		gramaje = (255 - long(paso_cliche)) / 255 *  ancho * largo * gram_cm2
	
		
		update art_ver_op_aplicaciones
		set gramaje = :gramaje
		where empresa = :codigo_empresa
		and articulo = :articulo
		and version = :ver
		and operacion = :operacion
		and contadoraplicacion = :contadoraplicacion;
		
		f_mensaje_proceso (string (i)+" de "+string (total_regs), i, total_regs)
		
		// Cálculo del coste de MP
		select sum (coste_kg_formula * art_ver_op_aplicaciones.gramaje ) 
		into :coste_mp_operacion
		from art_ver_op_aplicaciones, prodformula
		where art_ver_op_aplicaciones.empresa = :codigo_empresa
		and art_ver_op_aplicaciones.formula = prodformula.formula
		and art_ver_op_aplicaciones.articulo = :articulo
		and art_ver_op_aplicaciones.operacion = :operacion
		and art_ver_op_aplicaciones.version = :ver;
	
		update art_ver_operaciones
		set coste_mp = :coste_mp_operacion 
		where empresa = :codigo_empresa
		and articulo = :articulo
		and version = :ver
		and operacion = :operacion;
		// Fin del cálculo del coste de MP
		
	next
	commit using SQLCA;

	destroy datos
end if
end event

