$PBExportHeader$w_mant_gastosbanco.srw
$PBExportComments$Mantenimiento de gastos por banco,tipodoc,naci_extra
forward
global type w_mant_gastosbanco from w_int_con_empresa
end type
type pb_salir from upb_salir within w_mant_gastosbanco
end type
type em_tipodoc from u_em_campo within w_mant_gastosbanco
end type
type em_banco from u_em_campo within w_mant_gastosbanco
end type
type pb_imp from upb_imprimir within w_mant_gastosbanco
end type
type dw_listado from datawindow within w_mant_gastosbanco
end type
type em_naciextra from u_em_campo within w_mant_gastosbanco
end type
type tab_1 from tab within w_mant_gastosbanco
end type
type tabpage_1 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_1
end type
type cb_grabar_cab from commandbutton within tabpage_1
end type
type cb_salir_cab from commandbutton within tabpage_1
end type
type dw_cab from u_datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_2 gb_2
cb_grabar_cab cb_grabar_cab
cb_salir_cab cb_salir_cab
dw_cab dw_cab
end type
type tabpage_2 from userobject within tab_1
end type
type cb_grabar from commandbutton within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type st_3 from statictext within tabpage_2
end type
type st_6 from statictext within tabpage_2
end type
type uo_cuenta from u_em_campo_2 within tabpage_2
end type
type uo_moneda from u_em_campo_2 within tabpage_2
end type
type em_porcentaje from u_em_campo within tabpage_2
end type
type em_importe from editmask within tabpage_2
end type
type st_imp from statictext within tabpage_2
end type
type cb_sal from commandbutton within tabpage_2
end type
type cb_insertar from commandbutton within tabpage_2
end type
type uo_gasto from u_em_campo_2 within tabpage_2
end type
type gb_1 from groupbox within tabpage_2
end type
type dw_lineas from datawindow within tabpage_2
end type
type cb_borrar from commandbutton within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_grabar cb_grabar
st_2 st_2
st_3 st_3
st_6 st_6
uo_cuenta uo_cuenta
uo_moneda uo_moneda
em_porcentaje em_porcentaje
em_importe em_importe
st_imp st_imp
cb_sal cb_sal
cb_insertar cb_insertar
uo_gasto uo_gasto
gb_1 gb_1
dw_lineas dw_lineas
cb_borrar cb_borrar
cb_1 cb_1
end type
type tab_1 from tab within w_mant_gastosbanco
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type st_1 from statictext within w_mant_gastosbanco
end type
type st_11 from statictext within w_mant_gastosbanco
end type
type st_12 from statictext within w_mant_gastosbanco
end type
type st_banco from statictext within w_mant_gastosbanco
end type
type st_tipodoc from statictext within w_mant_gastosbanco
end type
type st_naciextra from statictext within w_mant_gastosbanco
end type
end forward

global type w_mant_gastosbanco from w_int_con_empresa
integer x = 5
integer y = 280
integer width = 2967
integer height = 1728
pb_salir pb_salir
em_tipodoc em_tipodoc
em_banco em_banco
pb_imp pb_imp
dw_listado dw_listado
em_naciextra em_naciextra
tab_1 tab_1
st_1 st_1
st_11 st_11
st_12 st_12
st_banco st_banco
st_tipodoc st_tipodoc
st_naciextra st_naciextra
end type
global w_mant_gastosbanco w_mant_gastosbanco

type variables
long numlinea
long numrow
datawindow dw_1,dw_2


end variables

forward prototypes
public subroutine f_salir_lineas (boolean sino)
end prototypes

public subroutine f_salir_lineas (boolean sino);tab_1.tabpage_2.cb_grabar.enabled 		= sino
tab_1.tabpage_2.cb_borrar.enabled 		= sino
tab_1.tabpage_2.cb_sal.enabled 			= sino
tab_1.tabpage_2.uo_gasto.enabled 		= sino
tab_1.tabpage_2.uo_cuenta.enabled 		= sino
tab_1.tabpage_2.em_importe.enabled 		= sino
tab_1.tabpage_2.em_porcentaje.enabled 	= sino
tab_1.tabpage_2.uo_moneda.enabled 		= sino

em_banco.enabled		=	not sino
em_tipodoc.enabled	=	not sino
em_naciextra.enabled	=	not sino
pb_imp.enabled			=	not sino




end subroutine

on w_mant_gastosbanco.create
int iCurrent
call super::create
this.pb_salir=create pb_salir
this.em_tipodoc=create em_tipodoc
this.em_banco=create em_banco
this.pb_imp=create pb_imp
this.dw_listado=create dw_listado
this.em_naciextra=create em_naciextra
this.tab_1=create tab_1
this.st_1=create st_1
this.st_11=create st_11
this.st_12=create st_12
this.st_banco=create st_banco
this.st_tipodoc=create st_tipodoc
this.st_naciextra=create st_naciextra
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_salir
this.Control[iCurrent+2]=this.em_tipodoc
this.Control[iCurrent+3]=this.em_banco
this.Control[iCurrent+4]=this.pb_imp
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.em_naciextra
this.Control[iCurrent+7]=this.tab_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_11
this.Control[iCurrent+10]=this.st_12
this.Control[iCurrent+11]=this.st_banco
this.Control[iCurrent+12]=this.st_tipodoc
this.Control[iCurrent+13]=this.st_naciextra
end on

on w_mant_gastosbanco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_salir)
destroy(this.em_tipodoc)
destroy(this.em_banco)
destroy(this.pb_imp)
destroy(this.dw_listado)
destroy(this.em_naciextra)
destroy(this.tab_1)
destroy(this.st_1)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_banco)
destroy(this.st_tipodoc)
destroy(this.st_naciextra)
end on

event ue_recuperar;call super::ue_recuperar;
// Valores Para Funcion de bloqueo


titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20 - longitud)
longitud      =  len(trim(em_banco.text))
criterio[2]   =  trim(em_banco.text)+space(20 - longitud)
longitud      =  len(trim(em_tipodoc.text))
criterio[3]   =  trim(em_tipodoc.text)+space(20 - longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         = "carbangas"


long cab,lin

lin=dw_1.Retrieve(codigo_empresa,em_banco.text,em_tipodoc.text,em_naciextra.text)
cab=dw_2.Retrieve(codigo_empresa,em_banco.text,em_tipodoc.text,em_naciextra.text)

if cab=0 and lin=0 then
	em_banco.enabled     = false
	em_tipodoc.enabled   = false
	em_naciextra.enabled = false
	pb_imp.enabled			= false
	tab_1.tabpage_2.enabled = false
	tab_1.SelectedTab = 1
	dw_2.insertrow(0)
	dw_2.setitem(dw_2.getrow(),"empresa",codigo_empresa)
	dw_2.setitem(dw_2.getrow(),"banco",em_banco.text)
	dw_2.setitem(dw_2.getrow(),"tipodoc",em_tipodoc.text)
	dw_2.setitem(dw_2.getrow(),"naciextra",em_naciextra.text)
	dw_2.setitem(dw_2.getrow(),"dias_anyo",360)
	dw_2.setfocus()
	dw_2.setcolumn("diasvalor")
else
	em_banco.enabled			= true
	em_tipodoc.enabled		= true
	em_naciextra.enabled		= true
	pb_imp.enabled				= true
	tab_1.tabpage_2.enabled	= true
end if
//CALL Super::ue_recuperar

end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Gastos Bancarios"
istr_parametros.s_listado        = ""
 This.title = istr_parametros.s_titulo_ventana
 
dw_1=tab_1.tabpage_2.dw_lineas
dw_2=tab_1.tabpage_1.dw_cab
dw_1.SetTransObject(SQLCA)
dw_2.SetTransObject(SQLCA)


   // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	em_banco.text=istr_parametros.s_argumentos[2]
   em_tipodoc.text=istr_parametros.s_argumentos[3]
	em_naciextra.text=istr_parametros.s_argumentos[4]
	IF Trim(em_banco.text)<>"" and Not IsNull(em_banco.text) &
		AND Trim(em_tipodoc.text) <> "" AND Not IsNull(em_tipodoc.text) &
		AND Trim(em_naciextra.text) <> "" AND Not IsNull(em_naciextra.text) Then
      f_activar_campo(tab_1.tabpage_2.uo_gasto.em_campo)
		TriggerEvent("ue_recuperar")
   END IF
END IF

//em_naciextra.text = "N"
em_banco.SetFocus()
tab_1.tabpage_2.cb_grabar.enabled = false
tab_1.tabpage_2.cb_borrar.enabled = false
tab_1.tabpage_2.cb_sal.enabled = false


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_cursor_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_mant_gastosbanco
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_mant_gastosbanco
end type

event sle_opcion_orden::getfocus;call super::getfocus;em_banco.setfocus()
end event

type st_empresa from w_int_con_empresa`st_empresa within w_mant_gastosbanco
integer x = 9
integer y = 32
integer width = 2309
end type

type pb_salir from upb_salir within w_mant_gastosbanco
integer x = 2766
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type em_tipodoc from u_em_campo within w_mant_gastosbanco
integer x = 1184
integer y = 232
integer width = 238
integer taborder = 20
maskdatatype maskdatatype = numericmask!
string mask = "######"
string displaydata = ""
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_cartipodoc"
ue_titulo     =  "AYUDA SELECCION DE TIPOS DE EFECTOS"
ue_filtro     =  ""
valor_empresa = true
end event

event modificado;call super::modificado;st_tipodoc.text = f_nombre_cartipodoc(codigo_empresa,em_tipodoc.text)
em_naciextra.text = "N"
end event

type em_banco from u_em_campo within w_mant_gastosbanco
integer x = 82
integer y = 232
integer width = 219
integer taborder = 10
maskdatatype maskdatatype = numericmask!
string mask = "######"
string displaydata = ""
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_carbancos"
ue_titulo     =  "AYUDA SELECCION DE BANCOS"
ue_filtro     =  ""
valor_empresa = true
end event

event modificado;call super::modificado;st_banco.text = f_nombre_banco(codigo_empresa,em_banco.text)
end event

type pb_imp from upb_imprimir within w_mant_gastosbanco
integer x = 2766
integer y = 168
integer taborder = 0
string picturename = "print!"
string disabledname = "c:\bmp\print_no.bmp"
end type

event clicked;call super::clicked;
dw_listado.SetTransObject(SQLCA)

dw_listado.Retrieve(codigo_empresa,Trim(em_banco.text))


f_imprimir_datawindow(dw_listado)




end event

type dw_listado from datawindow within w_mant_gastosbanco
boolean visible = false
integer x = 2277
integer y = 4
integer width = 215
integer height = 184
boolean bringtotop = true
string dataobject = "report_gastosbanco"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type em_naciextra from u_em_campo within w_mant_gastosbanco
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
integer x = 2034
integer y = 232
integer taborder = 30
string mask = "!"
string displaydata = "Ä"
end type

event modified;call super::modified;IF Trim(em_naciextra.text) = "N" THEN
	st_naciextra.text = "NACIONAL"
ELSE
	st_naciextra.text = "EXPORTACIÓN"
END IF

Parent.triggerevent("ue_recuperar")

end event

type tab_1 from tab within w_mant_gastosbanco
event create ( )
event destroy ( )
integer x = 9
integer y = 328
integer width = 2875
integer height = 1148
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2839
integer height = 1020
long backcolor = 12632256
string text = "Intereses"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "NestedReturn!"
long picturemaskcolor = 553648127
gb_2 gb_2
cb_grabar_cab cb_grabar_cab
cb_salir_cab cb_salir_cab
dw_cab dw_cab
end type

on tabpage_1.create
this.gb_2=create gb_2
this.cb_grabar_cab=create cb_grabar_cab
this.cb_salir_cab=create cb_salir_cab
this.dw_cab=create dw_cab
this.Control[]={this.gb_2,&
this.cb_grabar_cab,&
this.cb_salir_cab,&
this.dw_cab}
end on

on tabpage_1.destroy
destroy(this.gb_2)
destroy(this.cb_grabar_cab)
destroy(this.cb_salir_cab)
destroy(this.dw_cab)
end on

type gb_2 from groupbox within tabpage_1
integer x = 1751
integer width = 905
integer height = 156
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type cb_grabar_cab from commandbutton within tabpage_1
integer x = 1769
integer y = 48
integer width = 434
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;integer opcion,bien

bien = 0

IF dw_2.GetItemNumber(dw_2.getrow(),"dias_anyo") = 0 OR IsNull(dw_2.GetItemNumber(dw_2.getrow(),"dias_anyo")) THEN
	bien = 1
END IF

IF dw_2.GetItemString(dw_2.getrow(),"cta_interes") = "" OR IsNull(dw_2.GetItemString(dw_2.getrow(),"cta_interes")) THEN
	bien = 2
END IF


IF bien = 0 THEN
	opcion=messagebox("Proceso de modificación",&
							"Desea modificar el la cabecera",&
							question!,yesno!)
	if opcion=1 then
		dw_2.Update( )
		commit;
		cb_salir_cab.triggerevent(clicked!)
	end if
else
	CHOOSE CASE bien
		CASE 1
			MessageBox("ERROR DE DATOS","Debe introducir los dias del anyo para calculos", Exclamation!)
			dw_2.setfocus()
			dw_2.setcolumn("dias_anyo")
		CASE 2
			MessageBox("ERROR DE DATOS","Debe introducir la cuenta contable de Intereses", Exclamation!)
			dw_2.setfocus()
			dw_2.setcolumn("cta_interes")
	END CHOOSE
END IF

end event

type cb_salir_cab from commandbutton within tabpage_1
integer x = 2203
integer y = 48
integer width = 434
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;
em_banco.enabled			= true
em_tipodoc.enabled		= true
em_naciextra.enabled		= true
pb_imp.enabled				= true
tab_1.tabpage_2.enabled	= true

w_mant_gastosbanco.triggerevent("ue_recuperar")


end event

type dw_cab from u_datawindow within tabpage_1
integer x = 46
integer y = 156
integer width = 2757
integer height = 1192
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_carbangas"
boolean border = false
end type

event getfocus;call super::getfocus;em_banco.enabled		= false
em_tipodoc.enabled	= false
em_naciextra.enabled = false
pb_imp.enabled			= false
tab_1.tabpage_2.enabled = false


end event

event rbuttondown; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cta_interes"
      bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_titulo = "VENTANA SELECCION DE CUENTAS"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event key; bus_filtro=""
 valor_empresa = TRUE	
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "cta_interes"
      bus_datawindow = "dw_ayuda_contaplan_directo"
		bus_titulo = "VENTANA SELECCION DE CUENTAS"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
end event

type tabpage_2 from userobject within tab_1
event constructor pbm_constructor
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 2839
integer height = 1020
long backcolor = 12632256
string text = "Gastos"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "CreateRuntime!"
long picturemaskcolor = 553648127
cb_grabar cb_grabar
st_2 st_2
st_3 st_3
st_6 st_6
uo_cuenta uo_cuenta
uo_moneda uo_moneda
em_porcentaje em_porcentaje
em_importe em_importe
st_imp st_imp
cb_sal cb_sal
cb_insertar cb_insertar
uo_gasto uo_gasto
gb_1 gb_1
dw_lineas dw_lineas
cb_borrar cb_borrar
cb_1 cb_1
end type

event constructor;//uo_prima.taborder=1
//uo_envase.taborder=2
//em_cantidad.taborder=3
//uo_medida.taborder=4
//em_precio.taborder=5
//cb_grabar.taborder=0
//cb_insertar.taborder=0
//cb_borrar.taborder=0
//cb_sal.taborder=0
//dw_lineas.taborder=0
//this.taborder=0
//
//
//
end event

on tabpage_2.create
this.cb_grabar=create cb_grabar
this.st_2=create st_2
this.st_3=create st_3
this.st_6=create st_6
this.uo_cuenta=create uo_cuenta
this.uo_moneda=create uo_moneda
this.em_porcentaje=create em_porcentaje
this.em_importe=create em_importe
this.st_imp=create st_imp
this.cb_sal=create cb_sal
this.cb_insertar=create cb_insertar
this.uo_gasto=create uo_gasto
this.gb_1=create gb_1
this.dw_lineas=create dw_lineas
this.cb_borrar=create cb_borrar
this.cb_1=create cb_1
this.Control[]={this.cb_grabar,&
this.st_2,&
this.st_3,&
this.st_6,&
this.uo_cuenta,&
this.uo_moneda,&
this.em_porcentaje,&
this.em_importe,&
this.st_imp,&
this.cb_sal,&
this.cb_insertar,&
this.uo_gasto,&
this.gb_1,&
this.dw_lineas,&
this.cb_borrar,&
this.cb_1}
end on

on tabpage_2.destroy
destroy(this.cb_grabar)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.uo_cuenta)
destroy(this.uo_moneda)
destroy(this.em_porcentaje)
destroy(this.em_importe)
destroy(this.st_imp)
destroy(this.cb_sal)
destroy(this.cb_insertar)
destroy(this.uo_gasto)
destroy(this.gb_1)
destroy(this.dw_lineas)
destroy(this.cb_borrar)
destroy(this.cb_1)
end on

type cb_grabar from commandbutton within tabpage_2
event clicked pbm_bnclicked
integer x = 2368
integer y = 832
integer width = 229
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grabar"
end type

event clicked;String vgasto,vcuenta,vmoneda,vbanco,vtipodoc,vnaciextra
Decimal vimporte,vporcen

vbanco 		= dw_2.GetItemString(dw_2.GetRow(),"banco")
vtipodoc 	= dw_2.GetItemString(dw_2.GetRow(),"tipodoc")
vnaciextra 	= dw_2.GetItemString(dw_2.GetRow(),"naciextra")
vgasto 		= uo_gasto.em_codigo.text
vporcen 		= Dec(em_porcentaje.text)
vimporte 	= Dec(em_importe.text)
vmoneda 		= uo_moneda.em_codigo.text
vcuenta 		= Trim(uo_cuenta.em_codigo.text)


// Control de campos nulos

IF Trim(vgasto) = "" OR IsNull(vgasto) THEN
		uo_gasto.em_campo.SetFocus()
		RETURN
END IF

IF (vporcen = 0 OR IsNull(vporcen)) AND (vimporte = 0 OR IsNull(vimporte)) THEN
		em_porcentaje.SetFocus()
		RETURN
END IF	

IF Trim(vcuenta) = "" OR IsNull(vcuenta) THEN
		uo_cuenta.em_campo.SetFocus()
		RETURN
END IF

IF Trim(vmoneda) = "" OR IsNull(vmoneda) THEN
		uo_moneda.em_campo.SetFocus()
		RETURN
END IF
  	
IF cb_borrar.enabled=TRUE THEN
	UPDATE carlbangas SET 	porcentaje	= :vporcen,
	 								importe		= :vimporte,
									moneda		= :vmoneda,
									cuenta		= :vcuenta
 	WHERE carlbangas.empresa 	= :codigo_empresa
	AND   carlbangas.banco 		= :vbanco
	AND   carlbangas.tipodoc 	= :vtipodoc
	AND   carlbangas.naciextra = :vnaciextra
	AND   carlbangas.gasto 		= :vgasto USING SQLCA;
	 
	IF SQLCA.SQLCode <> 0 THEN 
		messagebox("Error al modificar el gasto",sqlca.sqlerrtext)
		ROLLBACK;
	ELSE
		COMMIT;
	END IF
ELSE
	INSERT INTO carlbangas ( empresa,banco,tipodoc,naciextra,gasto,
									porcentaje,importe,moneda,cuenta)
  			 VALUES (:codigo_empresa,:vbanco,:vtipodoc,:vnaciextra,:vgasto,
						:vporcen,:vimporte,:vmoneda,:vcuenta) USING SQLCA;
	IF SQLCA.SQLCode <> 0 THEN 
		messagebox("Error al insertar GASTO",sqlca.sqlerrtext)
		ROLLBACK;
	ELSE
		COMMIT;
	END IF
END IF

dw_1.Retrieve(codigo_empresa,em_banco.text,em_tipodoc.text,em_naciextra.text)

uo_gasto.em_codigo.text=""
uo_gasto.em_campo.text=""
em_porcentaje.text=""
em_importe.text=""
uo_cuenta.em_codigo.text=""
uo_cuenta.em_campo.text=""
uo_moneda.em_codigo.text=""
uo_moneda.em_campo.text=""
uo_gasto.em_campo.setfocus()
dw_1.selectrow(0,false)

end event

type st_2 from statictext within tabpage_2
integer x = 1326
integer y = 828
integer width = 878
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cuenta Contable"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_2
integer x = 713
integer y = 828
integer width = 315
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Porcentaje"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_2
integer x = 2208
integer y = 828
integer width = 146
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Mon"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_cuenta from u_em_campo_2 within tabpage_2
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1326
integer y = 908
integer width = 878
integer taborder = 40
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cuenta.em_campo.text=f_nombre_contaplan(ejercicio_activo,codigo_empresa,uo_cuenta.em_codigo.text)
If Trim(uo_cuenta.em_campo.text)="" Then
	If Trim(uo_cuenta.em_codigo.text)<>"" then uo_cuenta.em_campo.SetFocus()
	uo_cuenta.em_campo.text=""
	uo_cuenta.em_codigo.text=""
end if

end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_contaplan_directo"
ue_titulo     =  "AYUDA SELECCION DE CUENTAS CONTABLES"
ue_filtro     =  ""
valor_empresa = TRUE
end event

on uo_cuenta.destroy
call u_em_campo_2::destroy
end on

type uo_moneda from u_em_campo_2 within tabpage_2
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 2208
integer y = 908
integer width = 146
integer taborder = 60
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_moneda.em_campo.text=f_nombre_moneda_abr(uo_moneda.em_codigo.text)
If Trim(uo_moneda.em_campo.text)="" Then
	If Trim(uo_moneda.em_codigo.text)<>"" then uo_moneda.em_campo.SetFocus()
	uo_moneda.em_campo.text=""
	uo_moneda.em_codigo.text=""
end if


end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_divisas"
ue_titulo     =  "AYUDA SELECCION DE MONEDAS"
ue_filtro     =  ""
valor_empresa = false
end event

on uo_moneda.destroy
call u_em_campo_2::destroy
end on

type em_porcentaje from u_em_campo within tabpage_2
event modified pbm_enmodified
integer x = 713
integer y = 904
integer width = 315
integer taborder = 20
boolean enabled = false
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###.00"
end type

type em_importe from editmask within tabpage_2
integer x = 1029
integer y = 904
integer width = 293
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###,##0.00"
end type

type st_imp from statictext within tabpage_2
integer x = 1029
integer y = 828
integer width = 297
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Importe"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_sal from commandbutton within tabpage_2
event clicked pbm_bnclicked
integer x = 2597
integer y = 904
integer width = 229
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;dw_1.Retrieve(codigo_empresa,em_banco.text,em_tipodoc.Text,em_naciextra.Text)
uo_gasto.em_codigo.text=""
uo_gasto.em_campo.text=""
em_porcentaje.text=""
em_importe.text=""
uo_cuenta.em_codigo.text=""
uo_cuenta.em_campo.text=""
uo_moneda.em_codigo.text=""
uo_moneda.em_campo.text=""

cb_grabar.enabled = TRUE
cb_borrar.enabled = false
cb_insertar.enabled = FALSE

dw_1.selectrow(0,false)
tab_1.tabpage_1.enabled=true

end event

type cb_insertar from commandbutton within tabpage_2
event clicked pbm_bnclicked
integer x = 2597
integer y = 832
integer width = 229
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;dw_1.Retrieve(codigo_empresa,em_banco.text,em_tipodoc.Text,em_naciextra.Text)
uo_gasto.em_codigo.text=""
uo_gasto.em_campo.text=""
em_porcentaje.text=""
em_importe.text=""
uo_cuenta.em_codigo.text=""
uo_cuenta.em_campo.text=""
uo_moneda.em_codigo.text=""
uo_moneda.em_campo.text=""

f_salir_lineas(TRUE)

cb_grabar.enabled = TRUE
cb_borrar.enabled = false
cb_insertar.enabled = FALSE
uo_gasto.em_campo.SetFocus()
tab_1.tabpage_1.enabled=false

end event

type uo_gasto from u_em_campo_2 within tabpage_2
integer y = 900
integer width = 713
integer taborder = 10
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_gasto.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_cargastos"
ue_titulo     =  "AYUDA SELECCION DE TIPOS DE GASTOS"
ue_filtro     =  ""
valor_empresa = true
end event

event modificado;call super::modificado;uo_gasto.em_campo.text=f_nombre_cargastos(codigo_empresa,uo_gasto.em_codigo.text)
If Trim(uo_gasto.em_campo.text)="" Then
	If Trim(uo_gasto.em_codigo.text)<>"" then uo_gasto.em_campo.SetFocus()
	uo_gasto.em_campo.text=""
	uo_gasto.em_codigo.text=""
end if
end event

type gb_1 from groupbox within tabpage_2
integer x = 2359
integer y = 796
integer width = 475
integer height = 192
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type dw_lineas from datawindow within tabpage_2
event clicked pbm_dwnlbuttonclk
integer x = 82
integer y = 4
integer width = 2697
integer height = 788
string dataobject = "dw_carlbangas"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row = 0 Then Return
this.selectrow(0,false)
this.selectrow(row,true)

cb_grabar.enabled = TRUE
cb_borrar.enabled = TRUE
cb_sal.enabled = true
cb_insertar.enabled = true
uo_gasto.enabled = TRUE
uo_moneda.enabled = TRUE
em_porcentaje.enabled = TRUE
uo_cuenta.enabled = TRUE
em_importe.enabled = TRUE

uo_gasto.em_codigo.text=dw_1.GetItemString(Row,"gasto")
uo_gasto.em_campo.text=f_nombre_cargastos(codigo_empresa,uo_gasto.em_codigo.text)
em_porcentaje.text=string(dw_1.GetItemNumber(Row,"porcentaje"))
em_importe.text=String(dw_1.GetItemNumber(Row,"importe"))
uo_moneda.em_codigo.text=dw_1.GetItemString(Row,"moneda")
uo_moneda.em_campo.text=f_nombre_moneda(uo_moneda.em_codigo.text)
uo_cuenta.em_codigo.text=dw_1.GetItemString(Row,"cuenta")
uo_cuenta.em_campo.text=f_nombre_contaplan(ejercicio_activo,codigo_empresa,uo_cuenta.em_codigo.text)
numrow=row

uo_gasto.TriggerEvent("modificado")
uo_gasto.ue_valor_anterior=uo_gasto.em_campo.text
//em_porcentaje.SetFocus()
//em_porcentaje.SelectText(1,Len(uo_gasto.em_campo.Text))
f_activar_campo(uo_gasto.em_campo)

em_banco.enabled=false
em_tipodoc.enabled=false
em_naciextra.enabled=false

tab_1.tabpage_1.enabled=false

end event

type cb_borrar from commandbutton within tabpage_2
event clicked pbm_bnclicked
integer x = 2368
integer y = 904
integer width = 229
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar"
end type

event clicked;String	vbanco,vtipodoc,vnaciextra,vgasto

vbanco 		= dw_2.GetiTemString(dw_2.GetRow(),"banco")
vtipodoc 	= dw_2.GetiTemString(dw_2.GetRow(),"tipodoc")
vnaciextra 	= dw_2.GetiTemString(dw_2.GetRow(),"naciextra")
vgasto 		= dw_1.GetiTemString(dw_1.GetRow(),"gasto")

DELETE FROM carlbangas
WHERE carlbangas.empresa 	= :codigo_empresa
AND   carlbangas.banco 		= :vbanco
AND   carlbangas.tipodoc 	= :vtipodoc
AND   carlbangas.naciextra = :vnaciextra
AND   carlbangas.gasto 		= :vgasto USING SQLCA;
 
IF SQLCA.SQLCode <> 0 then 
	Messagebox("Error al borrar la linea",sqlca.sqlerrtext)
	ROLLBACK;
ELSE
	COMMIT;
END IF
	
dw_1.Retrieve(codigo_empresa,em_banco.text,em_tipodoc.Text,em_naciextra.Text)

uo_gasto.em_codigo.text=""
uo_gasto.em_campo.text=""
em_porcentaje.text=""
em_importe.text=""
uo_cuenta.em_codigo.text=""
uo_cuenta.em_campo.text=""
uo_moneda.em_codigo.text=""
uo_moneda.em_campo.text=""
cb_grabar.enabled = FALSE
cb_borrar.enabled = false
cb_insertar.enabled = TRUE
uo_gasto.em_codigo.setfocus()
dw_1.selectrow(0,false)



end event

type cb_1 from commandbutton within tabpage_2
integer y = 828
integer width = 713
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Gasto"
end type

type st_1 from statictext within w_mant_gastosbanco
integer x = 78
integer y = 168
integer width = 1102
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Banco"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_11 from statictext within w_mant_gastosbanco
integer x = 1184
integer y = 168
integer width = 841
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tipo Efecto"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_12 from statictext within w_mant_gastosbanco
integer x = 2034
integer y = 168
integer width = 617
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nac / Expor"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_banco from statictext within w_mant_gastosbanco
integer x = 329
integer y = 236
integer width = 837
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_tipodoc from statictext within w_mant_gastosbanco
integer x = 1431
integer y = 236
integer width = 603
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_naciextra from statictext within w_mant_gastosbanco
integer x = 2290
integer y = 236
integer width = 357
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

