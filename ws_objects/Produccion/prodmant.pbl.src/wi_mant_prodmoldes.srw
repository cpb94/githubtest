$PBExportHeader$wi_mant_prodmoldes.srw
forward
global type wi_mant_prodmoldes from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_prodmoldes
end type
type cb_1 from commandbutton within wi_mant_prodmoldes
end type
end forward

global type wi_mant_prodmoldes from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 2729
integer height = 1212
pb_calculadora pb_calculadora
cb_1 cb_1
end type
global wi_mant_prodmoldes wi_mant_prodmoldes

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



istr_parametros.s_titulo_ventana  = "Mantenimiento de Moldes"
This.title = istr_parametros.s_titulo_ventana

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF



	
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"activo","S")

end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "prodmoldes"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_prodmoldes.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.cb_1
end on

on wi_mant_prodmoldes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.cb_1)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prodmoldes
integer x = 46
integer y = 284
integer width = 1952
integer height = 600
string dataobject = "dw_mant_prodmoldes"
end type

event dw_1::rbuttondown; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "formato"
   		bus_titulo     = "AYUDA SELECCION DE FORMATOS"
			bus_datawindow = "dw_ayuda_formatos"
			bus_filtro     = "" 
			
	CASE "marco"
		bus_titulo     = "AYUDA SELECCION DE MARCOS"
		bus_datawindow = "dw_ayuda_prodmarcos"
		bus_filtro     = "activo = 'S' "	

	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown


end event

event dw_1::key; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "formato"
   		bus_titulo     = "AYUDA SELECCION DE FORMATOS"
			bus_datawindow = "dw_ayuda_formatos"
			bus_filtro     = "" 		

	CASE "marco"
		bus_titulo     = "AYUDA SELECCION DE MARCOS"
		bus_datawindow = "dw_ayuda_prodmarcos"
		bus_filtro     = "activo = 'S' "	
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prodmoldes
integer x = 59
integer y = 176
integer width = 270
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prodmoldes
integer x = 2039
end type

event cb_insertar::clicked;String descrip
if this.enabled then
	descrip = dw_1.GetItemString(dw_1.GetRow(),"descripcion")
	
	if IsNull(descrip) or Trim(descrip) = "" then
		f_mensaje("Guardar datos del Molde","Ha de introducir la descripción.")
		dw_1.SetFocus()
		return
	end if
end if
Call super::clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prodmoldes
integer x = 2039
integer y = 396
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prodmoldes
integer x = 361
integer y = 172
string mask = "###"
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prodmoldes"
ue_titulo               = "AYUDA SELECCION DE MOLDES"
ue_filtro               =""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prodmoldes
integer x = 2039
integer y = 504
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prodmoldes
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prodmoldes
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prodmoldes
integer width = 2437
end type

type pb_calculadora from u_calculadora within wi_mant_prodmoldes
integer x = 626
integer y = 164
integer width = 114
integer height = 100
integer taborder = 0
boolean originalsize = false
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select   count(*) 
 Into       :registros
 From     prodmoldes
 Where  prodmoldes.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,prodmoldes.codigo)+1)
  Into     :sle_valor.text
  From   prodmoldes
  Where  prodmoldes.empresa = :codigo_empresa;
END IF
//sle_valor.text = right("000"+trim(sle_valor.text),3)

dw_1.triggerEvent("clicked")
 

end event

type cb_1 from commandbutton within wi_mant_prodmoldes
boolean visible = false
integer x = 2034
integer y = 772
integer width = 535
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Partes a mogollón"
end type

event clicked;string sel
datastore datos
int piezasprensado
string articulo, formato
long i, piezas

sel = " select articulos.codigo , articulos.formato, prodmoldes.piezasprensado "+&
		" from articulos, prodmoldes, art_codestadistico "+&
		" where articulos.empresa = '"+codigo_empresa+"' "+&
		" and articulos.empresa = art_codestadistico.empresa "+&
		" and articulos.codigo = art_codestadistico.codigo "+&
		" and articulos.empresa = prodmoldes.empresa "+&
		" and articulos.molde = prodmoldes.codigo   "+&
		" and articulos.uso = '1' "+&
		" and ( art_codestadistico.g2 = 'B' or art_codestadistico.g2 = 'Z' ) "
		
f_cargar_cursor_nuevo (sel, datos)

connect using sqlca;

for i = 1 to datos.rowcount()
	articulo = datos.object.articulos_codigo[i]
	formato = datos.object.articulos_formato[i]
	piezasprensado = datos.object.prodmoldes_piezasprensado[i]
	
	piezas = piezasprensado * 7 * 60
	
	insert into prodpartes_ot
	(empresa, operario, linea, fecha, turno, contador, seccion, ot, ot_terminada, art_terminado, articulo, version, operacion, anyo, pedido, linped,
	buenas, malas, formato, ordenoperacion, horainicio, horafin, segundos, ajuste, factor )
	values ( :codigo_empresa, '1','31', '01-10-06', '1', :i, '5', 2,'N', 'N', :articulo, '1', '28', 2006, 0, 1,  :piezas, 0, :formato, 1, 
	'1900-01-01 00:00:00', '1900-01-01 01:00:00', 3600, 'N',1);
	f_mensaje_proceso ("BASES", i, datos.rowcount())
next

commit;
end event

