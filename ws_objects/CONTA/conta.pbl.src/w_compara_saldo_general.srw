$PBExportHeader$w_compara_saldo_general.srw
$PBExportComments$€
forward
global type w_compara_saldo_general from w_int_con_empresa
end type
type pb_2 from upb_salir within w_compara_saldo_general
end type
type cb_1 from u_boton within w_compara_saldo_general
end type
type uo_tipo from u_marca_lista within w_compara_saldo_general
end type
type dw_proceso from datawindow within w_compara_saldo_general
end type
type cb_consulta from u_boton within w_compara_saldo_general
end type
type pb_imprimir_preli from picturebutton within w_compara_saldo_general
end type
type dw_listado from datawindow within w_compara_saldo_general
end type
type uo_tipo2 from u_marca_lista within w_compara_saldo_general
end type
type dw_proceso2 from datawindow within w_compara_saldo_general
end type
type gb_4 from groupbox within w_compara_saldo_general
end type
type gb_3 from groupbox within w_compara_saldo_general
end type
type gb_2 from groupbox within w_compara_saldo_general
end type
type uo_tercero from u_em_campo_2 within w_compara_saldo_general
end type
type cb_2 from u_boton within w_compara_saldo_general
end type
type gb_cuenta from groupbox within w_compara_saldo_general
end type
type st_1 from statictext within w_compara_saldo_general
end type
type uo_ejercicio from u_ejercicio within w_compara_saldo_general
end type
type rb_pagos from radiobutton within w_compara_saldo_general
end type
type rb_cobros from radiobutton within w_compara_saldo_general
end type
type dw_proceso_c from datawindow within w_compara_saldo_general
end type
type rb_nacional from radiobutton within w_compara_saldo_general
end type
type rb_exportacion from radiobutton within w_compara_saldo_general
end type
type cbx_todo from checkbox within w_compara_saldo_general
end type
type dw_1 from datawindow within w_compara_saldo_general
end type
end forward

global type w_compara_saldo_general from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3410
integer height = 2320
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_1 cb_1
uo_tipo uo_tipo
dw_proceso dw_proceso
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipo2 uo_tipo2
dw_proceso2 dw_proceso2
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
uo_tercero uo_tercero
cb_2 cb_2
gb_cuenta gb_cuenta
st_1 st_1
uo_ejercicio uo_ejercicio
rb_pagos rb_pagos
rb_cobros rb_cobros
dw_proceso_c dw_proceso_c
rb_nacional rb_nacional
rb_exportacion rb_exportacion
cbx_todo cbx_todo
dw_1 dw_1
end type
global w_compara_saldo_general w_compara_saldo_general

type variables
String ante_articulo,retrasos,isle_campo


str_paramemp em
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
public subroutine f_cargar_viejo (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);Integer registros,i,k,dec_moneda_emp
String  pro1,pro2,var_cuenta
string  situacion,marca
string  proveedor,cuenta
string  sel,tipoter,filtro_tercero,sel1,sel2,sel3
string  tercero,razon,filtro_pais
dec     importe_cartera,saldo_contable,debe,haber
string  cuenta_inmovilizado_lp,var_nacional
long    donde,indice,total_cuentas,indice2,total
long    total_terceros,indice_terceros
dec     ejer
Datetime fdesde,fhasta
string is_filtro=""
datastore terceros
datastore importes
datastore cuentas
datastore saldos
datastore saldos2

dec_moneda_emp = f_decimales_moneda(moneda_empresa_secundaria)
ejer   = dec(uo_ejercicio.em_ejercicio.text)	
fdesde = datetime(date("01/01/"+uo_ejercicio.em_ejercicio.text))
fhasta = datetime(date("31/12/"+uo_ejercicio.em_ejercicio.text))

f_mascara_columna(dw_data,"importe_cartera",f_mascara_decimales(dec_moneda_emp))
f_mascara_columna(dw_data,"saldo_contable",f_mascara_decimales(dec_moneda_emp))
f_mascara_columna(dw_data,"resta",f_mascara_decimales(dec_moneda_emp))


dw_data.SetTransObject(sqlca)
dw_data.reset()
dw_data.setfilter("")
dw_data.filter()
dw_data.SetRedraw(FALSE)

uo_tipo.visible    = FALSE
uo_tipo2.visible   = FALSE

if rb_pagos.checked then
	tipoter = "P"
else
	tipoter = "C" 
end if

if rb_exportacion.checked then
	var_nacional = "N"
	filtro_pais  = " and pais <> '11'"
else
	var_nacional = "S"
	filtro_pais = " and pais = '11'"
end if

dw_data.retrieve(codigo_empresa,tipoter,var_nacional)

situacion = ""
for i = 1 to uo_tipo.dw_marca.rowcount()
	marca = uo_tipo.dw_marca.getitemstring(i,"marca")
	if marca = "S" then
		if situacion = "" then
			situacion = "'"+uo_tipo.dw_marca.getitemstring(i,"codigo")+"'"
		else
			situacion = situacion +",'"+uo_tipo.dw_marca.getitemstring(i,"codigo")+"'"
		end if
	end if
next

if situacion <> "" then
	situacion = " and situacion in("+situacion+")"
	
	iF Trim(uo_tercero.em_codigo.text) = "" Then
		filtro_tercero = ""
	ELSE
		filtro_tercero = " and codigo ='"+uo_tercero.em_codigo.text+"'"
	END IF
	
	sel = "select codigo,razon "+&
			"from genter "+&
			"where empresa = '"+codigo_empresa+"' "+&
			"and tipoter   = '"+tipoter+"' "+&
			filtro_tercero+&
			filtro_pais

//	terceros	= f_cargar_cursor(sel)
	f_cargar_cursor_nuevo(sel, terceros)
	
	total_terceros = terceros.rowcount()
	
	for indice_terceros = 1 to total_terceros
		f_mensaje_proceso("Procesando",indice_terceros,total_terceros)
		
		razon   = terceros.object.razon[indice_terceros]
		tercero = terceros.object.codigo[indice_terceros]
		
		if rb_pagos.checked then
			sel = "select sum(importe) importe "+&
					"from carpagos "+&
					"where empresa = '"+codigo_empresa+"' "+&
					"and proveedor ='"+tercero+"' "+&
					situacion
		else
			sel = "select sum(importe) importe "+&
					"from carefectos "+&
					"where empresa = '"+codigo_empresa+"' "+&
					"and cliente ='"+tercero+"' "+&
					situacion
		end if
		
		//importes = f_cargar_cursor(sel)
		f_cargar_cursor_nuevo(sel, importes)
		
		if importes.rowcount() = 1 then
			importe_cartera = importes.object.importe[1]
			if isnull(importe_cartera) then importe_cartera = 0
		else
			importe_cartera = 0
		end if
		saldo_contable = 0
		if rb_pagos.checked then
			sel1 = "select * "+&
					 "from comproveedores_cuenta "+&
					 "where empresa = '"+codigo_empresa+"' "+&
					 "and codigo ='"+tercero+"' "
//			cuentas = f_cargar_cursor(sel1)
			f_cargar_cursor_nuevo(sel1, cuentas)
			total_cuentas = cuentas.rowcount()
			for indice = 1 to total_cuentas
				var_cuenta = cuentas.object.cuenta[indice]
				// Calculamos los saldos iniciales
				sel2 = "select empresa,cuenta,fapunte,debe,haber,ejercicio "+&
						 "from   contaapun "+&
						 "where  empresa = '"+codigo_empresa+"' "+&
						 "and    origen = '101' "+&
						 "and    ejercicio = "+string(ejer,"####")+" "+&
						 "and    cuenta = '"+var_cuenta+"' "
				
//				saldos = f_cargar_cursor(sel2)		
				f_cargar_cursor_nuevo(sel2, saldos)
				total = saldos.rowcount()
				if total = 0 then
					sel2 = "select empresa,cuenta,fapunte,debe,haber,ejercicio "+&
							 "from   contaapun "+&
							 "where  empresa = '"+codigo_empresa+"' "+&
							 "and    ejercicio = "+string(ejer - 1,"####")+" "+&
							 "and    cuenta = '"+var_cuenta+"' "
					//saldos = f_cargar_cursor(sel2)		
					f_cargar_cursor_nuevo(sel2, saldos)
					total = saldos.rowcount()
				end if
				for indice2 = 1 to total
					debe   = saldos.object.debe[indice2]
					haber  = saldos.object.haber[indice2]
					saldo_contable = saldo_contable + (debe - haber)
				next
				// Calculando Periodo
				sel3 = "select empresa,cuenta,fapunte,cuenta,debe,haber,ejercicio "+&
						 "from   contaapun "+&
						 "where  empresa = '"+codigo_empresa+"' "+&
						 "and    origen <> '101' "+&
						 "and    origen <> '100' "+&
						 "and    origen <> '102' "+&
						 "and    ejercicio = "+string(ejer,"####")+" "+&
						 "and    cuenta = '"+var_cuenta+"' "
				
				//saldos2 = f_cargar_cursor(sel3)		
				f_cargar_cursor_nuevo(sel3,saldos2)
				
				total = saldos2.rowcount()
				
				for indice2 = 1 to total
					debe   = saldos2.object.debe[indice2]
					haber  = saldos2.object.haber[indice2]
					saldo_contable = saldo_contable + (debe - haber)
				next
				destroy saldos
				destroy saldos2
			next
			destroy cuentas
		else
			cuenta         = f_cuenta_genter(codigo_empresa,tipoter,tercero)
			// Calculamos los saldos iniciales
			sel2 = "select empresa,cuenta,fapunte,debe,haber,ejercicio "+&
					 "from   contaapun "+&
					 "where  empresa = '"+codigo_empresa+"' "+&
					 "and    origen = '101' "+&
					 "and    ejercicio = "+string(ejer,"####")+" "+&
					 "and    cuenta = '"+cuenta+"' "
			
			//saldos = f_cargar_cursor(sel2)		
			f_cargar_cursor_nuevo(sel2, saldos)
			total = saldos.rowcount()
			if total = 0 then
				sel2 = "select empresa,cuenta,fapunte,debe,haber,ejercicio "+&
						 "from   contaapun "+&
						 "where  empresa = '"+codigo_empresa+"' "+&
						 "and    ejercicio = "+string(ejer - 1,"####")+" "+&
						 "and    cuenta = '"+cuenta+"' "
				//saldos = f_cargar_cursor(sel2)		
				f_cargar_cursor_nuevo(sel2, saldos)
				total = saldos.rowcount()
			end if
			for indice2 = 1 to total
				debe   = saldos.object.debe[indice2]
				haber  = saldos.object.haber[indice2]
				saldo_contable = saldo_contable + (debe - haber)
			next
			// Calculando Periodo
			sel3 = "select empresa,cuenta,fapunte,cuenta,debe,haber,ejercicio "+&
					 "from   contaapun "+&
					 "where  empresa = '"+codigo_empresa+"' "+&
					 "and    origen <> '101' "+&
					 "and    origen <> '100' "+&
					 "and    origen <> '102' "+&
					 "and    ejercicio = "+string(ejer,"####")+" "+&
					 "and    cuenta = '"+cuenta+"' "
			
			//saldos2 = f_cargar_cursor(sel3)		
			f_cargar_cursor_nuevo(sel3, saldos2)
			total = saldos2.rowcount()
			
			for indice2 = 1 to total
				debe   = saldos2.object.debe[indice2]
				haber  = saldos2.object.haber[indice2]
				saldo_contable = saldo_contable + (debe - haber)
			next
			destroy saldos
			destroy saldos2
		end if
		
		donde = dw_data.insertrow(0)
		dw_data.setitem(donde,"saldo_contable",saldo_contable)
		dw_data.setitem(donde,"importe_cartera",importe_cartera)
		dw_data.setitem(donde,"razon",razon)
	next
else
	messagebox("Atención","Debe marcar alguna situación")
end if
destroy terceros
destroy importes

if cbx_todo.checked then
	dw_data.setfilter("")
else
	dw_data.setfilter("importe_cartera <> 0 or saldo_contable <> 0")
end if
dw_data.filter()
dw_data.SetRedraw(TRUE)
dw_data.Sort()
dw_data.GroupCalc()
end subroutine

public subroutine f_cargar_viejo (datawindow dw_data);//Integer registros,i,k,dec_moneda_emp
//String pro1,pro2
//string situacion[],marca
//
//
//dec_moneda_emp = f_decimales_moneda(em.moneda_emp)
//
//
//f_mascara_columna(dw_data,"importe_cartera",f_mascara_decimales(dec_moneda_emp))
//f_mascara_columna(dw_data,"saldo_contable",f_mascara_decimales(dec_moneda_emp))
//f_mascara_columna(dw_data,"resta",f_mascara_decimales(dec_moneda_emp))
//
//
//
//dw_data.reset()
//dw_data.visible   = FALSE
//uo_tipo.visible   = FALSE
//uo_tipo2.visible   = FALSE
//string is_filtro=""
//
//dw_data.SetTransObject(sqlca)
//
//k = 0
//for i = 1 to uo_tipo.dw_marca.rowcount()
//	marca = uo_tipo.dw_marca.getitemstring(i,"marca")
//	if marca = "S" then
//		k = k + 1		
//		situacion[k] = uo_tipo.dw_marca.getitemstring(i,"codigo")
//	end if
//next
//
//
//iF Trim(uo_proveedor.em_codigo.text) = "" Then
//   pro1 = "."
//   pro2 = "Z"
//ELSE
//	pro1 = uo_proveedor.em_codigo.text
//	pro2 = uo_proveedor.em_codigo.text
//END IF
//
//Datetime fecha1,fecha2
//
//
//dw_data.Retrieve(codigo_empresa,pro1,pro2,situacion)
//
//registros = dw_data.RowCount()
//If registros = 0 Then Return
//
//
//
//string proveedor,cuenta
//dec saldo,ejer
//ejer = dec(uo_ejercicio.em_ejercicio.text)
//
//for i = 1 to dw_data.rowcount()
//	f_mensaje_proceso("Procesando",i,dw_data.rowcount())
//	
//	proveedor = dw_data.getitemstring(i,"proveedor")
//	cuenta = f_cuenta_genter(codigo_empresa,"P",proveedor)
//	saldo = f_saldo_cuenta_nivel5(ejer,codigo_empresa,cuenta)
//	dw_data.setitem(i,"saldo_contable",saldo)
//
//
//next
//
//
end subroutine

event ue_listar;dw_report= dw_listado
dw_report.SetTransObject(SQLCA)
CALL Super::ue_listar
end event

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA DE SALDO CONTABLE Y CARTERA"

dw_1.Setfocus()


Integer x1,registros 
String var_codigo,var_texto,marca
dw_proceso.SetTransObject(SQLCA)
dw_proceso_c.SetTransObject(SQLCA)

registros=dw_proceso.retrieve(codigo_empresa)
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso.GetItemString(x1,"SITUACION")
  var_texto   = dw_proceso.GetItemString(x1,"descripcion")
  if var_codigo = "2"  or var_codigo = "9" then 
  	  marca = "N"	
  else
     marca="S"  
  end if
  
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF



uo_tipo.st_titulo1.text="Situación"
uo_tipo.st_titulo2.text="Descripcion"


Integer x2,registros2 
String var_codigo2,var_texto2,marca2
dw_proceso2.SetTransObject(SQLCA)
registros2=dw_proceso2.retrieve(codigo_empresa)
If registros2<>0 THEN
 FOR x2= 1 To registros2
  var_codigo2  = dw_proceso2.GetItemString(x2,"tipodoc")
  var_texto2   = dw_proceso2.GetItemString(x2,"texto")
  marca2="S"
  uo_tipo2.dw_marca.InsertRow(x2)
  uo_tipo2.dw_marca.setitem(x2,"marca",marca2)
  uo_tipo2.dw_marca.setitem(x2,"codigo",var_codigo2)
  uo_tipo2.dw_marca.setitem(x2,"texto",var_texto2)
NEXT
END IF
uo_tipo2.st_titulo1.text="Tipo Doc."
uo_tipo2.st_titulo2.text="Descripcion"

f_activar_campo(uo_tercero.em_campo)

em = f_paramemp(codigo_empresa)
end event

on w_compara_saldo_general.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
this.uo_tipo=create uo_tipo
this.dw_proceso=create dw_proceso
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipo2=create uo_tipo2
this.dw_proceso2=create dw_proceso2
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.uo_tercero=create uo_tercero
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.st_1=create st_1
this.uo_ejercicio=create uo_ejercicio
this.rb_pagos=create rb_pagos
this.rb_cobros=create rb_cobros
this.dw_proceso_c=create dw_proceso_c
this.rb_nacional=create rb_nacional
this.rb_exportacion=create rb_exportacion
this.cbx_todo=create cbx_todo
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.uo_tipo
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.cb_consulta
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.uo_tipo2
this.Control[iCurrent+9]=this.dw_proceso2
this.Control[iCurrent+10]=this.gb_4
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.uo_tercero
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.gb_cuenta
this.Control[iCurrent+16]=this.st_1
this.Control[iCurrent+17]=this.uo_ejercicio
this.Control[iCurrent+18]=this.rb_pagos
this.Control[iCurrent+19]=this.rb_cobros
this.Control[iCurrent+20]=this.dw_proceso_c
this.Control[iCurrent+21]=this.rb_nacional
this.Control[iCurrent+22]=this.rb_exportacion
this.Control[iCurrent+23]=this.cbx_todo
this.Control[iCurrent+24]=this.dw_1
end on

on w_compara_saldo_general.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.uo_tipo)
destroy(this.dw_proceso)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipo2)
destroy(this.dw_proceso2)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.uo_tercero)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.st_1)
destroy(this.uo_ejercicio)
destroy(this.rb_pagos)
destroy(this.rb_cobros)
destroy(this.dw_proceso_c)
destroy(this.rb_nacional)
destroy(this.rb_exportacion)
destroy(this.cbx_todo)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_compara_saldo_general
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_compara_saldo_general
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_compara_saldo_general
integer y = 20
integer width = 3163
integer height = 84
end type

type pb_2 from upb_salir within w_compara_saldo_general
integer x = 3214
integer y = 4
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_1 from u_boton within w_compara_saldo_general
integer x = 1157
integer y = 212
integer width = 297
integer height = 72
integer taborder = 50
string text = "&Situación"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo2.visible = false
dw_1.visible = FALSE
end event

type uo_tipo from u_marca_lista within w_compara_saldo_general
boolean visible = false
integer x = 1413
integer y = 316
integer width = 1449
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_proceso from datawindow within w_compara_saldo_general
boolean visible = false
integer x = 567
integer width = 494
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carpagos"
boolean livescroll = true
end type

type cb_consulta from u_boton within w_compara_saldo_general
integer x = 1751
integer y = 212
integer width = 279
integer height = 72
integer taborder = 60
string text = "&Consulta"
end type

event clicked;f_cargar(dw_1)
if dw_1.rowcount() > 0 then
	dw_1.visible   = TRUE
end if
f_activar_campo(uo_tercero.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_compara_saldo_general
integer x = 2551
integer y = 196
integer width = 114
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;f_imprimir_datawindow(dw_1)
f_activar_campo(uo_tercero.em_campo)
end event

type dw_listado from datawindow within w_compara_saldo_general
boolean visible = false
integer x = 2574
integer width = 160
integer height = 136
string dataobject = "report_compara_saldo_general"
boolean livescroll = true
end type

type uo_tipo2 from u_marca_lista within w_compara_saldo_general
boolean visible = false
integer x = 242
integer y = 320
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type dw_proceso2 from datawindow within w_compara_saldo_general
boolean visible = false
integer x = 110
integer width = 325
integer height = 116
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos_tipodoc"
boolean livescroll = true
end type

type gb_4 from groupbox within w_compara_saldo_general
integer x = 1755
integer y = 96
integer width = 823
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_3 from groupbox within w_compara_saldo_general
integer x = 1138
integer y = 96
integer width = 617
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_compara_saldo_general
integer x = 1138
integer y = 176
integer width = 914
integer height = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type uo_tercero from u_em_campo_2 within w_compara_saldo_general
event destroy ( )
integer x = 23
integer y = 196
integer width = 1070
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_tercero.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION CLIENTES/PROVEEDORES"
IF rb_cobros.checked Then	
	ue_datawindow = "dw_ayuda_clientes"
else
	ue_datawindow = "dw_ayuda_proveedores"
end if


end event

event modificado;
IF rb_cobros.checked Then	
	uo_tercero.em_campo.text=f_razon_genter(codigo_empresa,"C",uo_tercero.em_codigo.text)
else
	uo_tercero.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_tercero.em_codigo.text)
end if

If Trim(uo_tercero.em_campo.text)="" then
	uo_tercero.em_campo.text=""
	uo_tercero.em_codigo.text=""
	Return
end if 

dw_1.Reset()

end event

type cb_2 from u_boton within w_compara_saldo_general
event clicked pbm_bnclicked
integer x = 1454
integer y = 212
integer width = 297
integer height = 72
integer taborder = 40
boolean bringtotop = true
string text = "&Tipo Doc."
end type

event clicked;call super::clicked;uo_tipo2.visible = true
uo_tipo.visible = false
dw_1.visible = FALSE
end event

type gb_cuenta from groupbox within w_compara_saldo_general
integer y = 96
integer width = 1138
integer height = 200
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_1 from statictext within w_compara_saldo_general
integer x = 27
integer y = 144
integer width = 1070
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "P r o v e e d o r"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_ejercicio from u_ejercicio within w_compara_saldo_general
event destroy ( )
integer x = 2725
integer y = 212
integer height = 276
integer taborder = 70
boolean bringtotop = true
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type rb_pagos from radiobutton within w_compara_saldo_general
integer x = 1161
integer y = 132
integer width = 251
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pagos"
boolean checked = true
end type

event clicked;long registros,x1
string var_texto,var_codigo,marca

st_1.text = "Proveedor"
dw_1.reset()
uo_tercero.em_campo.text=""
uo_tercero.em_codigo.text=""

registros = dw_proceso.retrieve(codigo_empresa)
uo_tipo.dw_marca.reset()

If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso.GetItemString(x1,"SITUACION")
  var_texto   = dw_proceso.GetItemString(x1,"descripcion")
  if var_codigo = "2" or var_codigo = "9" then 
  	  marca = "N"	
  else
     marca="S"  
  end if
  
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF

end event

type rb_cobros from radiobutton within w_compara_saldo_general
integer x = 1463
integer y = 128
integer width = 265
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cobros"
end type

event clicked;long registros,x1
string var_texto,var_codigo,marca


st_1.text = "Cliente"
dw_1.reset()
uo_tercero.em_campo.text=""
uo_tercero.em_codigo.text=""

registros=dw_proceso_c.retrieve(codigo_empresa)
uo_tipo.dw_marca.reset()
If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso_c.GetItemString(x1,"codigo")
  var_texto   = dw_proceso_c.GetItemString(x1,"descripcion")
  if var_codigo = "3" or var_codigo = "4" or var_codigo = "7" or var_codigo = "5" then 
  	  marca = "N"	
  else
     marca="S"  
  end if
  
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF

end event

type dw_proceso_c from datawindow within w_compara_saldo_general
boolean visible = false
integer x = 443
integer y = 16
integer width = 494
integer height = 116
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_carefectos"
boolean livescroll = true
end type

type rb_nacional from radiobutton within w_compara_saldo_general
integer x = 1778
integer y = 132
integer width = 315
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nacional"
boolean checked = true
end type

event clicked;dw_1.reset()
end event

type rb_exportacion from radiobutton within w_compara_saldo_general
integer x = 2158
integer y = 132
integer width = 393
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Exportación"
end type

event clicked;dw_1.reset()
end event

type cbx_todo from checkbox within w_compara_saldo_general
integer x = 2615
integer y = 120
integer width = 722
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Incluir Prov. con saldo 0"
boolean lefttext = true
end type

event clicked;if cbx_todo.checked then
	dw_1.setfilter("")
else
	dw_1.setfilter("importe_cartera <> 0 or saldo_contable <> 0")
end if
dw_1.filter()
dw_1.SetRedraw(TRUE)
dw_1.Sort()
dw_1.GroupCalc()
end event

type dw_1 from datawindow within w_compara_saldo_general
boolean visible = false
integer x = 5
integer y = 312
integer width = 3328
integer height = 1764
string dataobject = "dw_compara_saldo_general"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;Integer linea,an,ord
String agrup
linea = row
if linea=0 then return
agrup =  This.GetItemString(linea,"agrupado")

if agrup="S" Then
	
 an =this.GetItemNumber(row,"anyo")
 ord =this.GetItemNumber(row,"orden")

	str_parametros lstr_param 
   lstr_param.i_nargumentos=3
   lstr_param.s_argumentos[1]=codigo_empresa
   lstr_param.s_argumentos[2]=string(an)
   lstr_param.s_argumentos[3]=string(ord)

   OpenWithParm(w_detalle_agrupado,lstr_param)


End If
end event

