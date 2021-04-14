$PBExportHeader$w_liquidacion_comisiones_old.srw
$PBExportComments$€
forward
global type w_liquidacion_comisiones_old from w_int_con_empresa
end type
type gb_fecha from groupbox within w_liquidacion_comisiones_old
end type
type em_fechahasta from u_em_campo within w_liquidacion_comisiones_old
end type
type cb_continuar from commandbutton within w_liquidacion_comisiones_old
end type
type uo_agente from u_em_campo_2 within w_liquidacion_comisiones_old
end type
type st_4 from statictext within w_liquidacion_comisiones_old
end type
type tipo from statictext within w_liquidacion_comisiones_old
end type
type uo_ejercicio from u_ejercicio within w_liquidacion_comisiones_old
end type
type em_fapunte from u_em_campo within w_liquidacion_comisiones_old
end type
type st_1 from statictext within w_liquidacion_comisiones_old
end type
type cb_1 from commandbutton within w_liquidacion_comisiones_old
end type
type sle_documento from singlelineedit within w_liquidacion_comisiones_old
end type
type st_2 from statictext within w_liquidacion_comisiones_old
end type
type pb_1 from upb_salir within w_liquidacion_comisiones_old
end type
type dw_1 from datawindow within w_liquidacion_comisiones_old
end type
end forward

global type w_liquidacion_comisiones_old from w_int_con_empresa
integer width = 2985
integer height = 1692
gb_fecha gb_fecha
em_fechahasta em_fechahasta
cb_continuar cb_continuar
uo_agente uo_agente
st_4 st_4
tipo tipo
uo_ejercicio uo_ejercicio
em_fapunte em_fapunte
st_1 st_1
cb_1 cb_1
sle_documento sle_documento
st_2 st_2
pb_1 pb_1
dw_1 dw_1
end type
global w_liquidacion_comisiones_old w_liquidacion_comisiones_old

type variables
 string detalle="S",con="1",todo = "S"
end variables

forward prototypes
public subroutine f_procesar ()
public function boolean f_apuntes_contables ()
end prototypes

public subroutine f_procesar ();
Integer r,r1,vbien,liquidacion
Dec impliqui,impliquipts,vanyo,vfactura,vlinea,anyo_liquidacion
datetime fecha_liquidacion

r1 = dw_1.RowCount()
vbien = 0

fecha_liquidacion = datetime(date(em_fapunte.text))
 
anyo_liquidacion = year(date(em_fapunte.text))
 
// Último nº de liquidación
select max(doc_liquidacion) into :liquidacion
from carcomisiones
where	(carcomisiones.empresa = :codigo_empresa) and
		(carcomisiones.anyo = :anyo_liquidacion );
if isnull(liquidacion) then liquidacion = 0

liquidacion = liquidacion + 1


For r = 1 To r1
 IF dw_1.GetItemString(r,"marca") = "S" Then
	
	impliquipts = dw_1.GetItemNumber(r,"carcomisiones_comisionliquipts")
	impliqui    = dw_1.GetItemNumber(r,"carcomisiones_comisionliqui")
	vanyo       = dw_1.GetItemNumber(r,"anyo")
	vfactura    = dw_1.GetItemNumber(r,"factura")
	vlinea      = dw_1.GetItemNumber(r,"linea")
	
	UPDATE carcomisiones 
	SET    liquidado = "S"  ,
	       importeliquidadopts = :impliquipts,
		    importeliquidado    = :impliqui,
			 carcomisiones.fliquidacion = :fecha_liquidacion,
			 carcomisiones.doc_liquidacion = :liquidacion
   WHERE  carcomisiones.empresa = :codigo_empresa
	AND    carcomisiones.anyo    = :vanyo 
	AND    carcomisiones.factura = :vfactura 
	AND    carcomisiones.linea   = :vlinea;
	
	IF SQLCA.SQLCODE <> 0 Then vbien =1
	
 END IF
	
	f_mensaje_proceso("Cancelando recibos.......",r,r1)
   
Next
// No hacemos apuntes contables
//IF Not f_apuntes_contables() Then vbien = 1

IF vbien= 0 Then
	if r1 > 0 then
		sle_documento.text = string(liquidacion)
	end if
	
	COMMIT;
ELSE
	ROLLBACK;
	f_mensaje("Error en proceso","La OPeracion no se contabiliza")
END IF
cb_continuar.TriggerEvent(Clicked!)
end subroutine

public function boolean f_apuntes_contables ();str_contaapun conta
String ante
Integer v_bien,r,r1
Dec acumulado = 0,acu2 = 0
IF tipo_vista<> "Nacional"  Then Return true

r1 = dw_1.RowCount()
v_bien = 0
acu2 = 0
conta.empresa   = codigo_empresa
conta.fapunte   = DateTime(Date(em_fapunte.text))
conta.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
conta.origen    = "5"
conta.mes       = Month(date(conta.fapunte))
conta.asiento   = f_ultimo_asiento(conta.ejercicio,conta.empresa,conta.mes,conta.origen)
conta.concepto  = "8"
conta.apunte    = 0
ante= ""

For r = 1 To r1
    IF dw_1.GetItemString(r,"marca") = "S" Then
			acumulado  = acumulado + dw_1.GetItemNumber(r,"importeliquidarpts")
			iF (Trim(ante)<> "" and ante <> dw_1.GetItemString(r,"agente")) Then
					IF acu2<>0 then
							conta.apunte  = conta.apunte + 1
							IF Not f_insert_contaapun(conta) Then 	
									v_bien = 1
									f_mensaje("Error","AL GRABAR ASIENTO")
							END IF
					End if
					acu2 = 0
			END IF
			acu2  = acu2 + dw_1.GetItemNumber(r,"importeliquidarpts")
			conta.ampliacion  = f_nombre_mes(conta.mes)+ "  " +f_nombre_venagentes(conta.empresa,dw_1.GetItemString(r,"agente"))
			conta.divisas =acu2
			conta.debe =acu2
			conta.haber =0
			conta.deducible  = "N"
			conta.actualizado= "N"
			conta.listado = "N"
			SetNull(conta.registro)
			SetNUll(conta.tipoter) 
			SetNUll(conta.clipro)
			SetNull(conta.conciliado)
			SetNUll(conta.nif)
			SetNull(conta.punteado)
			SetNull(conta.fvalor)
			SetNull(conta.docpunteo)
			SetNull(conta.coste)
			SetNull(conta.fregistro)
			conta.moneda = dw_1.GetItemString(r,"moneda")
			conta.cambio = 1
			conta.documento = ""
			conta.factura   = ""
			SetNUll(conta.ffactura)  
			conta.imponible = 0
			SetNull(conta.tipoiva)
			SetNUll(conta.iva)
			conta.cuenta  = f_cuenta_venagentes(codigo_empresa,dw_1.GetItemString(r,"agente"))
			ante = dw_1.GetItemString(r,"agente")
   END IF
	f_mensaje_proceso("Procesando Apuntes.......",r,r1)
Next
conta.apunte  = conta.apunte + 1
if acu2<>0 then
		IF Not f_insert_contaapun(conta) Then 	
				v_bien = 1
				f_mensaje("Error","AL GRABAR ASIENTO")
		END IF
End if

conta.apunte  = conta.apunte + 1
conta.debe    =0
conta.haber   = acumulado
conta.divisas = acumulado
conta.ampliacion = f_nombre_mes(conta.mes)
conta.cuenta  = "41200999"
IF Not f_insert_contaapun(conta) Then 	
	v_bien = 1
	f_mensaje("Error","AL GRABAR ASIENTO")
END IF

if v_bien = 1 Then
	Return False
Else
	Return True
End If



end function

on w_liquidacion_comisiones_old.create
int iCurrent
call super::create
this.gb_fecha=create gb_fecha
this.em_fechahasta=create em_fechahasta
this.cb_continuar=create cb_continuar
this.uo_agente=create uo_agente
this.st_4=create st_4
this.tipo=create tipo
this.uo_ejercicio=create uo_ejercicio
this.em_fapunte=create em_fapunte
this.st_1=create st_1
this.cb_1=create cb_1
this.sle_documento=create sle_documento
this.st_2=create st_2
this.pb_1=create pb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_fecha
this.Control[iCurrent+2]=this.em_fechahasta
this.Control[iCurrent+3]=this.cb_continuar
this.Control[iCurrent+4]=this.uo_agente
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.tipo
this.Control[iCurrent+7]=this.uo_ejercicio
this.Control[iCurrent+8]=this.em_fapunte
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.sle_documento
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.pb_1
this.Control[iCurrent+14]=this.dw_1
end on

on w_liquidacion_comisiones_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_fecha)
destroy(this.em_fechahasta)
destroy(this.cb_continuar)
destroy(this.uo_agente)
destroy(this.st_4)
destroy(this.tipo)
destroy(this.uo_ejercicio)
destroy(this.em_fapunte)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.sle_documento)
destroy(this.st_2)
destroy(this.pb_1)
destroy(this.dw_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Liquidacion Agentes"
istr_parametros.s_listado        =   "report_conpromalb2"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)

em_fechahasta.text=string(today(),"dd-mm-yy")
em_fapunte.text=string(today(),"dd-mm-yy")
f_mascara_columna(dw_1,"importeliquidarpts",f_mascara_decimales(2))


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_liquidacion_comisiones_old
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_liquidacion_comisiones_old
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_fechahasta)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_liquidacion_comisiones_old
integer x = 18
integer y = 20
end type

type gb_fecha from groupbox within w_liquidacion_comisiones_old
integer x = 9
integer y = 152
integer width = 361
integer height = 176
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "F. Hasta"
end type

type em_fechahasta from u_em_campo within w_liquidacion_comisiones_old
integer x = 46
integer y = 228
integer width = 288
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type cb_continuar from commandbutton within w_liquidacion_comisiones_old
event clicked pbm_bnclicked
integer x = 1600
integer y = 244
integer width = 329
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;String filtro,ag1,ag2
Dec g,g1
dw_1.setredraw(false)
filtro = ""

IF tipo_vista= "Nacional"    Then 
	filtro     = "carcomisiones_nacional = 'S'"
  ELSE
  	IF tipo_vista = "Extranjero" then 
		filtro     = "carcomisiones_nacional = 'N'"
	else
		filtro = ""
	end if
END IF


IF todo <> "S" Then
	if filtro <> "" then 
	 	filtro     = filtro + " and cobrado = 'S' and carcomisiones_control_fletes = 'S'"
	else
		filtro     = filtro + "cobrado = 'S' and carcomisiones_control_fletes = 'S'"
	end if	
END IF

if tipo_vista = "" or isnull(tipo_vista) then
	tipo.text = "Ambos"
	tipo_vista = "Ambos"
else
	tipo.text = tipo_vista
end if


dw_1.SetFilter(filtro)
dw_1.Filter()
ag1 = "0"
ag2 = "Z"
IF uo_agente.em_codigo.text <> "" Then
ag1 =	uo_agente.em_codigo.text
ag2 = uo_agente.em_codigo.text
END IF

g1 = dw_1.retrieve(codigo_empresa,datetime(date(em_fechahasta.text)),ag1,ag2)
dec f
For f =  1 To g1
	IF tipo_vista= "Nacional"    Then 
          dw_1.SetItem(f,"marca","S")
	   else
			 IF dw_1.GetItemString(f,"cobrado") = "S" and dw_1.GetItemString(f,"carcomisiones_control_fletes")= "S" Then
         		dw_1.SetItem(f,"marca","S")
          END IF
	End if
Next
dw_1.Visible = TRUE
dw_1.setredraw( true)




end event

type uo_agente from u_em_campo_2 within w_liquidacion_comisiones_old
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 375
integer y = 240
integer width = 1221
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)
IF Trim(uo_agente.em_campo.text)="" THEN 
 IF Trim(uo_agente.em_codigo.text)<>"" Then uo_agente.em_campo.SetFocus()
 uo_agente.em_campo.text=""
 uo_agente.em_codigo.text=""
END IF





end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de agentes"
ue_datawindow = "dw_ayuda_venagentes"
ue_filtro     = ""
//IF tipo_vista= "Nacional"    Then   ue_filtro     = "nacional = 'S'"
//IF tipo_vista= "Exportacion" Then   ue_filtro     = "nacional = 'N'"
//
//
//
end event

on uo_agente.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_liquidacion_comisiones_old
integer x = 375
integer y = 164
integer width = 1225
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Agente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type tipo from statictext within w_liquidacion_comisiones_old
integer x = 1600
integer y = 164
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_ejercicio from u_ejercicio within w_liquidacion_comisiones_old
boolean visible = false
integer x = 2208
integer y = 144
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type em_fapunte from u_em_campo within w_liquidacion_comisiones_old
integer x = 1952
integer y = 236
integer width = 283
integer taborder = 0
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_1 from statictext within w_liquidacion_comisiones_old
integer x = 1943
integer y = 164
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "F. Liquid."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_liquidacion_comisiones_old
integer x = 2245
integer y = 236
integer width = 311
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Procesar"
end type

event clicked;
long op,op2,reg,i 
string cobrado,naci,marca
boolean sin_cobrar

sle_documento.text = ""
sin_cobrar = false

if not isdate(em_fapunte.text) then
	messagebox("Error en Introducción de datos","Fecha de liquidación NO válida")
	return
end if

if uo_agente.em_codigo.text = "" then
	messagebox("Error en Introducción de datos","Debe introducir un AGENTE")
	return
end if


reg = dw_1.rowcount()

if reg > 0 then
	op = messagebox(" Atención "," ¿ Desea liquidar las comisiones seleccionadas ?",question!,yesno!,2)
	if op = 2 then return

	// Avisamos si se han seleccionado comisiones que no se han cobrado	
	
	for i = 1 to reg
		
		marca = dw_1.getitemstring(i,"marca")
		cobrado = dw_1.getitemstring(i,"cobrado")
		naci = dw_1.getitemstring(i,"carcomisiones_nacional")
		
		if marca = "S" and cobrado = "N" and naci = "N" then
			sin_cobrar = true
			exit
		end if		
		
		
		
	next
	
	
	if sin_cobrar then
		op2 = messagebox("Atención","Se han seleccionado comisiones de extranjero que NO se han cobrado, ¿ Desea continuar ?",question!,yesno!,2)
		if op2 = 2 then
			return			
		end if		
	end if
	
	f_procesar()
		
		
end if


end event

type sle_documento from singlelineedit within w_liquidacion_comisiones_old
integer x = 2565
integer y = 236
integer width = 242
integer height = 80
integer taborder = 31
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_liquidacion_comisiones_old
integer x = 2592
integer y = 168
integer width = 169
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Doc."
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_liquidacion_comisiones_old
integer x = 2715
integer y = 12
integer width = 110
integer height = 104
integer taborder = 0
boolean bringtotop = true
string picturename = "exit!"
end type

type dw_1 from datawindow within w_liquidacion_comisiones_old
integer x = 14
integer y = 340
integer width = 2834
integer height = 1092
string dataobject = "dw_liquidacion_comisiones_old"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;if currentrow = 0 tHEN Return
if GetRow() = 0 tHEN Return
IF This.GetItemString(currentrow,"cobrado") = "S" Then
	dw_1.SetTabOrder("importeliquidarpts",1)
ELSE
	dw_1.SetTabOrder("importeliquidarpts",0)
END IF

end event

event clicked;

IF f_objeto_datawindow(This) = "mar" Then
	IF con = "1" Then
		todo = "N"
		cb_continuar.TriggerEvent(Clicked!)
		con= "2"
	ELSE
		todo = "S"
		cb_continuar.TriggerEvent(Clicked!)
		con= "1"
	END IF
	RETURN
END IF



IF f_objeto_datawindow(dw_1) = "marca" THEN
	
	if row > 0 then
		
		IF dw_1.getItemString(row,"marca") = "S" Then
			dw_1.SetItem(row,"marca","N")
		ELSE
			dw_1.SetItem(row,"marca","S")
		END IF
		
	end if
	
END IF


end event

