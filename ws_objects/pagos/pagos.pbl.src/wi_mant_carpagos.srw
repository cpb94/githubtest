$PBExportHeader$wi_mant_carpagos.srw
forward
global type wi_mant_carpagos from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_carpagos
end type
type gb_1 from groupbox within wi_mant_carpagos
end type
type st_2 from statictext within wi_mant_carpagos
end type
type em_anyo from u_em_campo within wi_mant_carpagos
end type
end forward

global type wi_mant_carpagos from wi_mvent_con_empresa
integer width = 2857
integer height = 1696
pb_calculadora pb_calculadora
gb_1 gb_1
st_2 st_2
em_anyo em_anyo
end type
global wi_mant_carpagos wi_mant_carpagos

type variables
dec   anteimporte
end variables

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento de Efectos de Pagos"
istr_parametros.s_listado         = ""
This.title = istr_parametros.s_titulo_ventana
em_anyo.text = String(year(Today()))
f_activar_campo(sle_valor)
// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	em_anyo.text   = istr_parametros.s_argumentos[2]
	sle_valor.text = istr_parametros.s_argumentos[3]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.Text))
	END IF
END IF


	
end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"orden",Dec(sle_valor.text))
 dw_1.setitem(dw_1.getrow(),"situacion","0")
 dw_1.setitem(dw_1.getrow(),"anyofra",dec(em_anyo.text))
 dw_1.setitem(dw_1.getrow(),"anyo",dec(em_anyo.text))


end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
longitud      =  len(trim(em_anyo.text))
criterio[3]   =  trim(em_anyo.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "carpagos"

dw_1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.Text))

if dw_1.rowcount() > 0 then 
	anteimporte = dw_1.object.importe[dw_1.getrow()]
else
	anteimporte = 0
end if

CALL Super::ue_recuperar
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_carpagos.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.gb_1=create gb_1
this.st_2=create st_2
this.em_anyo=create em_anyo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_anyo
end on

on wi_mant_carpagos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.em_anyo)
end on

event ue_actualiza_dw;call super::ue_actualiza_dw;dec importe
long anyo,orden,decimales_moneda
str_carpagos carpagos

importe = dw_1.object.importe[dw_1.getrow()]

if (anteimporte <> 0) and (importe < anteimporte) then
	if messagebox("Atención","Ha modificado el importe del efecto.~n¿Desea generar otro efecto por la diferencia?",Question!,YesNo!,2) = 1 then
		anyo  = dw_1.object.anyo[dw_1.getrow()]
		orden = dw_1.object.orden[dw_1.getrow()]
		
		if f_cargar_str_carpagos(codigo_empresa,anyo,orden,carpagos) then

			carpagos.orden   = f_ultimo_orden_carpagos(carpagos.empresa,carpagos.anyo)
			
			select max(carpagos.recibo)
			into   :carpagos.recibo
			from   carpagos
			where  carpagos.empresa = :carpagos.empresa
			and    carpagos.anyofra = :carpagos.anyofra
			and    carpagos.fra = :carpagos.fra;
			
			if isnull(carpagos.recibo) then carpagos.recibo = 0
			carpagos.recibo ++
			carpagos.importe = anteimporte - importe
			carpagos.divisas = carpagos.importe * carpagos.cambio
			
			decimales_moneda   = f_decimales_moneda(carpagos.moneda)
			carpagos.divisas = round(carpagos.divisas,decimales_moneda)
			
			IF Not f_insert_carpagos(carpagos) Then 
				rollback;
				messagebox("Error","Se ha producido un error al grabar en cartera")
			else
				commit;
				f_mensaje("Proceso Correcto","Se ha generado el recibo :~n"+&
								string(carpagos.anyo,"#,###")+"/"+string(carpagos.orden,"#,###")+&
								"  De "+f_razon_genter(codigo_empresa,"P",carpagos.proveedor)+&
								"~nPor un importe de "+string(carpagos.importe,"###,###,##0.00"+" €"))
																
			end if
		else			
			messagebox("Atención","Se ha producido un error al duplicar el efecto")
		end if
	end if
end if
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_carpagos
integer x = 82
integer y = 224
integer width = 2688
integer height = 1224
string dataobject = "dw_carpagos"
end type

event dw_1::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "proveedor"
 		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
	CASE "moneda"
 		bus_datawindow = "dw_ayuda_monedas"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
	CASE "banco","banco_recep"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
	CASE "tipodoc","tipodoc_pago"
 		bus_datawindow = "dw_ayuda_cartipodoc"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE DOCUMENTO"
 	CASE "tipo_proveedor"
		valor_empresa  = true
 		bus_datawindow = "dw_ayuda_comtipo_proveedor"
		bus_titulo     = "AYUDA SELECCION TIPOS DE PROVEEDOR"		
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key



end event

event dw_1::rbuttondown;long anyo,orden

valor_empresa = TRUE	
bus_filtro=""
bus_titulo=""
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "proveedor"
		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
	CASE "codpago"
		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
	CASE "moneda"
		bus_datawindow = "dw_ayuda_monedas"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
	CASE "banco","banco_recep"
		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
	CASE "tipodoc","tipodoc_pago"
		bus_datawindow = "dw_ayuda_cartipodoc"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE DOCUMENTO"
	CASE "tipo_proveedor"
		valor_empresa  = true
		bus_datawindow = "dw_ayuda_comtipo_proveedor"
		bus_titulo     = "AYUDA SELECCION TIPOS DE PROVEEDOR"	 
	CASE ELSE
		SetNull(bus_campo)
		if row > 0 then
			anyo  = this.object.anyo[row]
			orden = this.object.orden[row]
			f_muestra_detalle_pago_agrupado(anyo,orden,ypos + this.y + parent.y)
		end if				
END CHOOSE
CALL Super::rbuttondown



end event

event dw_1::itemchanged;String proveedor,codpago,moneda,cta
dec cambio,divisas,importe
int dec_moneda_emp

IF GetColumnName()= "proveedor" Then
	proveedor = data

	Select genter.moneda,genter.cuenta Into :moneda,:cta
	From   genter
	Where  empresa = :codigo_empresa
	And    tipoter = "P"
	ANd    codigo  = :proveedor;
	
	Select forma_pago
	Into   :codpago
	From   comproveedores
	Where  empresa = :codigo_empresa
	ANd    codigo  = :proveedor;
	
	SetItem(row,"moneda",moneda)
	IF moneda = '1' THEN SetItem(row,"cambio",1)
	SetItem(row,"codpago",codpago)
	SetItem(row,"cuenta",cta)	
END IF

dec_moneda_emp = f_decimales_moneda(f_moneda_empresa(codigo_empresa))

if dwo.name = "moneda" then
	cambio 	= f_cambio_moneda(data)	
	divisas 	= dw_1.getitemnumber(1,"divisas")

	if cambio <> 0 then
		importe = round(divisas / cambio,dec_moneda_emp)
		dw_1.setitem(1,"cambio",cambio)
		dw_1.setitem(1,"importe",importe)
	else
		messagebox("No se puede continuar","El cambio NO puede ser cero")
	end if
	
end if

if dwo.name = "divisas" then
	cambio = dw_1.getitemnumber(row,"cambio")
	divisas = dec(data)
	if cambio <> 0 then
		importe = round(divisas / cambio,dec_moneda_emp)
		dw_1.setitem(1,"importe",importe)
	end if	
end if


if dwo.name = "cambio" then
	cambio = dec(data)
	divisas = dw_1.getitemnumber(row,"divisas")		
	
	if cambio <> 0 then
		importe = round(divisas / cambio,dec_moneda_emp)
		dw_1.setitem(1,"importe",importe)
	end if	
	
end if





end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_carpagos
integer x = 535
integer y = 124
integer width = 247
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_carpagos
integer x = 1536
integer y = 116
integer width = 398
integer height = 80
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_carpagos
integer x = 1938
integer y = 116
integer width = 398
integer height = 80
end type

event cb_borrar::clicked;string agrupado

if dw_1.getrow() = 1 then
	agrupado = dw_1.object.agrupado[1]
	
	if agrupado = "S" then
		messagebox("Atención","No se puede borrar un efecto agrupado.")
	else
		call super::clicked
	end if
end if

end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_carpagos
integer x = 805
integer y = 120
integer textsize = -10
end type

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_carpagos
integer x = 2341
integer y = 116
integer width = 398
integer height = 80
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_carpagos
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_carpagos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_carpagos
integer width = 2734
end type

type pb_calculadora from u_calculadora within wi_mant_carpagos
integer x = 1070
integer y = 116
integer taborder = 0
end type

event clicked;call super::clicked;Dec var_anyo,registros
var_anyo = Dec(em_anyo.text)

IF cb_insertar.enabled=TRUE THEN Return
// Integer registros
// Select count(*) Into :registros
// From   carpagos
// Where  carpagos.empresa = :codigo_empresa
// ANd    carpagos.anyo    = :var_anyo;
// IF registros=0 THEN
//   sle_valor.text="1"
// ELSE
//  Select max(convert(int,carpagos.orden)+1)
//  Into   :sle_valor.text
//  From   carpagos
//  Where  carpagos.empresa = :codigo_empresa
//  And    carpagos.anyo    = :var_anyo;
//END IF

registros = f_ultimo_orden_carpagos(codigo_empresa,var_anyo)
sle_valor.text = string(registros,"#####0")
dw_1.triggerEvent("clicked")
  
end event

type gb_1 from groupbox within wi_mant_carpagos
integer x = 1527
integer y = 84
integer width = 1221
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_2 from statictext within wi_mant_carpagos
integer x = 91
integer y = 124
integer width = 174
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within wi_mant_carpagos
integer x = 274
integer y = 120
integer width = 233
integer textsize = -10
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "####"
string displaydata = "~r"
end type

