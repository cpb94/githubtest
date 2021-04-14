$PBExportHeader$w_con_dto_cliente.srw
forward
global type w_con_dto_cliente from w_int_con_empresa
end type
type st_1 from statictext within w_con_dto_cliente
end type
type dw_listado from datawindow within w_con_dto_cliente
end type
type uo_articulo from u_em_campo_2 within w_con_dto_cliente
end type
type uo_cliente from u_em_campo_2 within w_con_dto_cliente
end type
type uo_calidad from u_em_campo_2 within w_con_dto_cliente
end type
type em_dto3 from u_em_campo within w_con_dto_cliente
end type
type st_5 from statictext within w_con_dto_cliente
end type
type dw_tar1 from u_datawindow_consultas within w_con_dto_cliente
end type
type dw_tar3 from u_datawindow_consultas within w_con_dto_cliente
end type
type cb_borrar from u_boton within w_con_dto_cliente
end type
type cb_continuar from u_boton within w_con_dto_cliente
end type
type dw_tar2 from u_datawindow_consultas within w_con_dto_cliente
end type
type uo_formato from u_em_campo_2 within w_con_dto_cliente
end type
type em_dto2 from u_em_campo within w_con_dto_cliente
end type
type st_42 from statictext within w_con_dto_cliente
end type
type em_cantidad2 from u_em_campo within w_con_dto_cliente
end type
type em_cantidad3 from u_em_campo within w_con_dto_cliente
end type
type uo_familia from u_em_campo_2 within w_con_dto_cliente
end type
type em_dto1 from u_em_campo within w_con_dto_cliente
end type
type st_41 from statictext within w_con_dto_cliente
end type
type st_dto1 from statictext within w_con_dto_cliente
end type
type em_cantidad1 from u_em_campo within w_con_dto_cliente
end type
type gb_5 from groupbox within w_con_dto_cliente
end type
type gb_4 from groupbox within w_con_dto_cliente
end type
type pb_2 from upb_salir within w_con_dto_cliente
end type
type pb_3 from upb_imprimir within w_con_dto_cliente
end type
type uo_unidad1 from u_em_campo_2 within w_con_dto_cliente
end type
type st_cantidad1 from statictext within w_con_dto_cliente
end type
type gb_1 from groupbox within w_con_dto_cliente
end type
type st_cantidad2 from statictext within w_con_dto_cliente
end type
type uo_unidad2 from u_em_campo_2 within w_con_dto_cliente
end type
type st_dto2 from statictext within w_con_dto_cliente
end type
type st_cantidad3 from statictext within w_con_dto_cliente
end type
type st_dto3 from statictext within w_con_dto_cliente
end type
type gb_3 from groupbox within w_con_dto_cliente
end type
type st_unidad3 from statictext within w_con_dto_cliente
end type
type st_4 from statictext within w_con_dto_cliente
end type
type gb_2 from groupbox within w_con_dto_cliente
end type
end forward

global type w_con_dto_cliente from w_int_con_empresa
integer x = 27
integer y = 32
integer width = 3493
integer height = 2024
st_1 st_1
dw_listado dw_listado
uo_articulo uo_articulo
uo_cliente uo_cliente
uo_calidad uo_calidad
em_dto3 em_dto3
st_5 st_5
dw_tar1 dw_tar1
dw_tar3 dw_tar3
cb_borrar cb_borrar
cb_continuar cb_continuar
dw_tar2 dw_tar2
uo_formato uo_formato
em_dto2 em_dto2
st_42 st_42
em_cantidad2 em_cantidad2
em_cantidad3 em_cantidad3
uo_familia uo_familia
em_dto1 em_dto1
st_41 st_41
st_dto1 st_dto1
em_cantidad1 em_cantidad1
gb_5 gb_5
gb_4 gb_4
pb_2 pb_2
pb_3 pb_3
uo_unidad1 uo_unidad1
st_cantidad1 st_cantidad1
gb_1 gb_1
st_cantidad2 st_cantidad2
uo_unidad2 uo_unidad2
st_dto2 st_dto2
st_cantidad3 st_cantidad3
st_dto3 st_dto3
gb_3 gb_3
st_unidad3 st_unidad3
st_4 st_4
gb_2 gb_2
end type
global w_con_dto_cliente w_con_dto_cliente

type variables
String modo



end variables

forward prototypes
public subroutine f_cargar1 ()
public subroutine f_borrar1 ()
public subroutine f_cargar2 ()
public subroutine f_activar (string arg_modo)
public subroutine f_cargar3 ()
public subroutine f_borrar2 ()
public subroutine f_borrar3 ()
end prototypes

public subroutine f_cargar1 ();Integer reg
dw_tar1.Reset()
dw_tar2.Reset()
dw_tar3.Reset()

if dw_tar1.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,uo_calidad.em_codigo.text) > 0 then
	dw_tar1.SetRow(1)
	f_cargar2()
end if
end subroutine

public subroutine f_borrar1 ();If dw_tar1.GetRow() = 0 Then Return
IF MessageBox("Proceso borrado Dtos.","Desea Borrar Todos los Dtos a la familia "+ dw_tar1.GetItemString(dw_tar1.GetRow(),"familias_descripcion"),Question!,YesNo!) = 1 Then
  String familia,cliente
  cliente = uo_cliente.em_codigo.text
  familia = dw_tar1.object.familia[dw_tar1.GetRow()]

  
   DELETE FROM vendtoartcli  
   WHERE vendtoartcli.empresa = :codigo_empresa 
	AND   vendtoartcli.cliente = :cliente;
//	AND   vendtoartcli.familia = :familia; // David  10-04-03
	
	DELETE FROM vendtofamcli  
   WHERE vendtofamcli.empresa = :codigo_empresa
	AND   vendtofamcli.cliente = :cliente;
//	AND   vendtofamcli.familia = :familia ; // David  10-04-03
	
	DELETE FROM vendtofamforcli  
   WHERE vendtofamforcli.empresa = :codigo_empresa 
	AND   vendtofamforcli.cliente = :cliente ;
//	AND   vendtofamforcli.familia = :familia; // David  10-04-03
	COMMIT;
	f_cargar1()
END IF

end subroutine

public subroutine f_cargar2 ();string var_familia

//IF dw_tar1.GetRow() = 0 Then 
//	dw_tar2.Reset()
//	dw_tar3.Reset()
//	Return
//END IF
//dw_tar2.Reset()
//dw_tar3.Reset()

//var_familia = dw_tar1.object.familia[dw_tar1.GetRow()]

//if dw_tar2.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,uo_calidad.em_codigo.text,var_familia) > 0 then
//	dw_tar2.SetRow(1)
//	f_cargar3()
//END IF

if dw_tar2.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,uo_calidad.em_codigo.text) > 0 then
	dw_tar2.SetRow(1)
	dw_tar2.selectrow(1,true)
	f_cargar3()
END IF



end subroutine

public subroutine f_activar (string arg_modo);modo = arg_modo
IF modo = "1" Then
//	dw_tar1.Setfocus()
END IF
IF modo = "2" Then
//	dw_tar2.Setfocus()
END IF
IF modo = "3" Then
//	dw_tar3.Setfocus()
END IF
end subroutine

public subroutine f_cargar3 ();string var_familia,var_formato

//IF dw_tar1.GetRow() = 0 Then 
//	dw_tar2.Reset()
//	dw_tar3.Reset()
//	Return
//END IF
//IF dw_tar2.GetRow() = 0 Then 
//	dw_tar3.Reset()
//	Return
//END IF

dw_tar3.Reset()
//var_familia = dw_tar1.object.familia[dw_tar1.GetRow()]
if dw_tar2.rowcount() > 0 then
	var_formato = dw_tar2.object.formato[dw_tar2.GetRow()]
end if

//dw_tar3.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,uo_calidad.em_codigo.text,var_familia,var_formato)
dw_tar3.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,uo_calidad.em_codigo.text,var_formato)




end subroutine

public subroutine f_borrar2 ();//IF dw_tar1.GetRow()= 0 Then Return  // David  10-04-03
IF dw_tar2.GetRow()= 0 Then Return
//IF MessageBox("Proceso borrado Dtos.","Desea Borrar Todos los Dtos a la familia "+ dw_tar1.GetItemString(dw_tar1.GetRow(),"familias_descripcion")+ " Formato " + dw_tar2.GetItemString(dw_tar2.GetRow(),"formatos_descripcion"),Question!,YesNo!) = 1 Then
IF MessageBox("Proceso borrado Dtos.","Desea Borrar Todos los Dtos del Formato "+ dw_tar2.GetItemString(dw_tar2.GetRow(),"formatos_descripcion"),Question!,YesNo!) = 1 Then
 String familia,cliente,formato
  cliente = uo_cliente.em_codigo.text
//  familia = dw_tar1.object.familia[dw_tar1.GetRow()]
  formato = dw_tar2.object.formato[dw_tar2.GetRow()]
  
   DELETE FROM vendtoartcli  
   WHERE vendtoartcli.empresa = :codigo_empresa 
	AND   vendtoartcli.cliente = :cliente
//	AND   vendtoartcli.familia = :familia // David  10-04-03
	AND   vendtoartcli.formato = :formato;

	
	DELETE FROM vendtofamforcli  
   WHERE vendtofamforcli.empresa = :codigo_empresa 
	AND   vendtofamforcli.cliente = :cliente 
//	AND   vendtofamforcli.familia = :familia // David  10-04-03
	AND   vendtofamforcli.formato = :formato;
	COMMIT;
	f_cargar2()
END IF


end subroutine

public subroutine f_borrar3 ();dec cantidad
IF dw_tar3.GetRow()= 0 Then Return
IF MessageBox("Proceso borrado Dtos.","Desea Borrar el Dto al articulo "+ dw_tar3.GetItemString(dw_tar3.GetRow(),"articulos_descripcion"),Question!,YesNo!) = 1 Then
String 	articulo,cliente
  cliente = uo_cliente.em_codigo.text
  articulo = dw_tar3.object.articulo[dw_tar3.GetRow()]
  cantidad = dw_tar3.object.cantidad[dw_tar3.GetRow()]
 
   DELETE FROM vendtoartcli  
   WHERE vendtoartcli.empresa  = :codigo_empresa 
	AND   vendtoartcli.cliente  = :cliente
	AND   vendtoartcli.articulo = :articulo
	and cantidad = :cantidad;
	COMMIT;
	f_cargar1()
END IF
end subroutine

event ue_listar;String filtro
dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.retrieve(codigo_empresa, uo_cliente.em_codigo.text)

//if trim(uo_cliente.em_codigo.text)<>"" then
//   filtro  = " cliente = '" + uo_cliente.em_codigo.text + "'"
//End if

IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta Tarifa por cliente"
This.title=istr_parametros.s_titulo_ventana
uo_calidad.em_codigo.text = "1"
uo_calidad.em_campo.text = f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
dw_listado.SetTransObject(SQLCA)
dw_tar1.SetTransObject(SQLCA)
dw_tar2.SetTransObject(SQLCA)
dw_tar3.SetTransObject(SQLCA)

f_activar_campo(uo_cliente.em_campo)



end event

on w_con_dto_cliente.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_listado=create dw_listado
this.uo_articulo=create uo_articulo
this.uo_cliente=create uo_cliente
this.uo_calidad=create uo_calidad
this.em_dto3=create em_dto3
this.st_5=create st_5
this.dw_tar1=create dw_tar1
this.dw_tar3=create dw_tar3
this.cb_borrar=create cb_borrar
this.cb_continuar=create cb_continuar
this.dw_tar2=create dw_tar2
this.uo_formato=create uo_formato
this.em_dto2=create em_dto2
this.st_42=create st_42
this.em_cantidad2=create em_cantidad2
this.em_cantidad3=create em_cantidad3
this.uo_familia=create uo_familia
this.em_dto1=create em_dto1
this.st_41=create st_41
this.st_dto1=create st_dto1
this.em_cantidad1=create em_cantidad1
this.gb_5=create gb_5
this.gb_4=create gb_4
this.pb_2=create pb_2
this.pb_3=create pb_3
this.uo_unidad1=create uo_unidad1
this.st_cantidad1=create st_cantidad1
this.gb_1=create gb_1
this.st_cantidad2=create st_cantidad2
this.uo_unidad2=create uo_unidad2
this.st_dto2=create st_dto2
this.st_cantidad3=create st_cantidad3
this.st_dto3=create st_dto3
this.gb_3=create gb_3
this.st_unidad3=create st_unidad3
this.st_4=create st_4
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.uo_articulo
this.Control[iCurrent+4]=this.uo_cliente
this.Control[iCurrent+5]=this.uo_calidad
this.Control[iCurrent+6]=this.em_dto3
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.dw_tar1
this.Control[iCurrent+9]=this.dw_tar3
this.Control[iCurrent+10]=this.cb_borrar
this.Control[iCurrent+11]=this.cb_continuar
this.Control[iCurrent+12]=this.dw_tar2
this.Control[iCurrent+13]=this.uo_formato
this.Control[iCurrent+14]=this.em_dto2
this.Control[iCurrent+15]=this.st_42
this.Control[iCurrent+16]=this.em_cantidad2
this.Control[iCurrent+17]=this.em_cantidad3
this.Control[iCurrent+18]=this.uo_familia
this.Control[iCurrent+19]=this.em_dto1
this.Control[iCurrent+20]=this.st_41
this.Control[iCurrent+21]=this.st_dto1
this.Control[iCurrent+22]=this.em_cantidad1
this.Control[iCurrent+23]=this.gb_5
this.Control[iCurrent+24]=this.gb_4
this.Control[iCurrent+25]=this.pb_2
this.Control[iCurrent+26]=this.pb_3
this.Control[iCurrent+27]=this.uo_unidad1
this.Control[iCurrent+28]=this.st_cantidad1
this.Control[iCurrent+29]=this.gb_1
this.Control[iCurrent+30]=this.st_cantidad2
this.Control[iCurrent+31]=this.uo_unidad2
this.Control[iCurrent+32]=this.st_dto2
this.Control[iCurrent+33]=this.st_cantidad3
this.Control[iCurrent+34]=this.st_dto3
this.Control[iCurrent+35]=this.gb_3
this.Control[iCurrent+36]=this.st_unidad3
this.Control[iCurrent+37]=this.st_4
this.Control[iCurrent+38]=this.gb_2
end on

on w_con_dto_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_listado)
destroy(this.uo_articulo)
destroy(this.uo_cliente)
destroy(this.uo_calidad)
destroy(this.em_dto3)
destroy(this.st_5)
destroy(this.dw_tar1)
destroy(this.dw_tar3)
destroy(this.cb_borrar)
destroy(this.cb_continuar)
destroy(this.dw_tar2)
destroy(this.uo_formato)
destroy(this.em_dto2)
destroy(this.st_42)
destroy(this.em_cantidad2)
destroy(this.em_cantidad3)
destroy(this.uo_familia)
destroy(this.em_dto1)
destroy(this.st_41)
destroy(this.st_dto1)
destroy(this.em_cantidad1)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.uo_unidad1)
destroy(this.st_cantidad1)
destroy(this.gb_1)
destroy(this.st_cantidad2)
destroy(this.uo_unidad2)
destroy(this.st_dto2)
destroy(this.st_cantidad3)
destroy(this.st_dto3)
destroy(this.gb_3)
destroy(this.st_unidad3)
destroy(this.st_4)
destroy(this.gb_2)
end on

event ue_f5;call super::ue_f5;cb_continuar.TriggerEvent(Clicked!)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;CHOOSE CASE modo
	CASE "1"
		f_cursor_abajo(dw_tar1)
	CASE "2"
		f_cursor_abajo(dw_tar2)
	CASE "3"
		f_cursor_abajo(dw_tar3)		
END CHOOSE


end event

event ue_cursor_arriba;call super::ue_cursor_arriba;CHOOSE CASE modo
	CASE "1"
		f_cursor_arriba(dw_tar1)
	CASE "2"
		f_cursor_arriba(dw_tar2)
	CASE "3"
		f_cursor_arriba(dw_tar3)		
END CHOOSE

end event

event ue_pagina_abajo;call super::ue_pagina_abajo;CHOOSE CASE modo
	CASE "1"
		f_pagina_abajo(dw_tar1)
	CASE "2"
		f_pagina_abajo(dw_tar2)
	CASE "3"
		f_pagina_abajo(dw_tar3)		
END CHOOSE

end event

event ue_pagina_arriba;call super::ue_pagina_arriba;CHOOSE CASE modo
	CASE "1"
		f_pagina_arriba(dw_tar1)
	CASE "2"
		f_pagina_arriba(dw_tar2)
	CASE "3"
		f_pagina_arriba(dw_tar3)		
END CHOOSE

end event

event ue_f2;call super::ue_f2;CHOOSE CASE modo
	CASE "1"
		f_borrar1()
	CASE "2"
		f_borrar2()
	CASE "3"
		f_borrar3()
END CHOOSE

end event

event activate;call super::activate;w_con_dto_cliente = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_dto_cliente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_dto_cliente
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_cliente.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_dto_cliente
integer x = 27
integer y = 8
integer width = 2427
end type

type st_1 from statictext within w_con_dto_cliente
integer x = 23
integer y = 164
integer width = 224
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_dto_cliente
boolean visible = false
integer x = 1742
integer width = 494
integer height = 84
boolean bringtotop = true
string dataobject = "report_con_dto_cliente1"
boolean livescroll = true
end type

type uo_articulo from u_em_campo_2 within w_con_dto_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1920
integer y = 1620
integer width = 1504
integer height = 72
integer taborder = 100
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
If Trim(uo_articulo.em_campo.text)="" then
	uo_articulo.em_campo.text=""
	uo_articulo.em_codigo.text=""
	st_unidad3.text = ""
	Return
else
	st_unidad3.text = f_nombre_unidad_abr(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text))
end if 

end event

event getfocus;call super::getfocus;//IF dw_tar1.GetRow()= 0 Then return
//IF dw_tar2.GetRow()= 0 Then return
ue_titulo = "Selección de Articulos"
ue_datawindow ="dw_ayuda_articulos"
//ue_filtro = "familia = '" +dw_tar1.object.familia[dw_tar1.GetRow()]+ & 
//"' and formato = '" +dw_tar2.object.formato[dw_tar2.GetRow()]+"' "+&
//"and cliente = '"+uo_cliente.em_codigo.text+"'"
ue_filtro = "cliente = '"+uo_cliente.em_codigo.text+"'"
f_activar("3")
end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type uo_cliente from u_em_campo_2 within w_con_dto_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 251
integer y = 156
integer width = 1614
integer taborder = 130
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
	dw_tar1.reset()
	dw_tar2.reset()
	dw_tar3.reset()
end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type uo_calidad from u_em_campo_2 within w_con_dto_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 2793
integer y = 156
integer width = 123
integer height = 88
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_calidad.em_campo.text=f_nombre_calidad_abr(codigo_empresa,uo_calidad.em_codigo.text)
If Trim(uo_calidad.em_campo.text)="" then
	uo_calidad.em_campo.text=""
	uo_calidad.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Calidades"
ue_datawindow ="dw_ayuda_calidades"
ue_filtro = ""
end event

on uo_calidad.destroy
call u_em_campo_2::destroy
end on

type em_dto3 from u_em_campo within w_con_dto_cliente
integer x = 3195
integer y = 1700
integer width = 201
integer height = 72
integer taborder = 120
string text = "0"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##0.00"
end type

event tecla_enter;call super::tecla_enter;String   v_cliente,cod_familia,v_calidad,cod_formato,cod_articulo,v_unidad
int      donde
Dec      v_cantidad,v_dto,numero
DateTime fecha
boolean  bien = true

fecha = datetime(Today(),now())
cod_articulo = uo_articulo.em_codigo.text
cod_familia  = ""//dw_tar1.object.familia[dw_tar1.GetRow()]
cod_formato  = f_formato_articulo(codigo_empresa,cod_articulo)//dw_tar2.object.formato[dw_tar2.GetRow()]
v_unidad     = f_unidad_articulo(codigo_empresa,cod_articulo)
v_cliente    = uo_cliente.em_codigo.text
v_calidad    = uo_calidad.em_codigo.text
v_dto        = Dec(em_dto3.text)
v_cantidad   = Dec(em_cantidad3.text)

IF IsNull(cod_articulo) Or Trim(cod_articulo) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca el articulo")
	f_activar_campo(uo_articulo.em_campo)
	Return
END IF

IF Trim(v_calidad) = "" Then
	f_mensaje("Campo obligatorio"," Introduzca la calidad")
	f_activar_campo(uo_calidad.em_campo)
	Return
END IF

//Pakito 11/06/01
Select Count(*) 
Into   :numero 
From   vendtofamforcli
Where  empresa  = :codigo_empresa
And    cliente  = :v_cliente
And    familia  = :cod_familia
And    formato  = :cod_formato
And    calidad  = :v_calidad
And    unidad   = :v_unidad;

IF IsNull(numero) Then numero = 0
IF numero = 0 Then
	INSERT INTO vendtofamforcli  
		(empresa,			cliente,			familia,
		 formato,			calidad,			dto,
		 cantidad,			unidad,			falta,
		 usuario )  
	VALUES 
		(:codigo_empresa,	:v_cliente,		:cod_familia,
		 :cod_formato,		:v_calidad,   	0,
		 0,		:v_unidad,		:fecha,
		 :nombre_usuario );
		 
	iF SQLCA.SQLCODE <> 0 Then 
		rollback;
		f_mensaje("Error",SQLca.SqlErrText)
		bien = false
	else
		commit;
		f_cargar2()
		donde = dw_tar2.find("formato = '"+cod_formato+"'",1,dw_tar2.rowcount())
		if donde > 0 then
			dw_tar2.SetRow(donde)
			dw_tar2.selectrow(0,false)
			dw_tar2.selectrow(donde,true)
		end if
	end if		 
end if

//

if bien then
	Select Count(*) 
	Into   :numero 
	From   vendtoartcli
	Where  empresa  = :codigo_empresa
	And    cliente  = :v_cliente
	And    articulo = :cod_articulo
	And    calidad  = :v_calidad
	And    cantidad = :v_cantidad;
	
	IF IsNull(numero) Then numero = 0
	IF numero = 0 Then
		INSERT INTO vendtoartcli  
			(empresa,			cliente,			articulo,
			 familia,			formato,			calidad,
			 dto,					cantidad,		falta,
			 usuario )  
		VALUES 
			(:codigo_empresa,	:v_cliente,		:cod_articulo,
			 :cod_familia,		:cod_formato,	:v_calidad,   
			 :v_dto,				:v_cantidad,	:fecha,
			 :nombre_usuario);
		
		iF SQLCA.SQLCODE <> 0 Then 
			rollback;
			f_mensaje("Error",SQLca.SqlErrText)
		else
			commit;
		end if	
	ELSE
		Update  vendtoartcli
		Set     dto      = :v_dto
		Where   empresa  = :codigo_empresa
		And     cliente  = :v_cliente
		And     articulo = :cod_articulo
		And     calidad  = :v_calidad
		And     cantidad = :v_cantidad;
		
		iF SQLCA.SQLCODE <> 0 Then 
			rollback;
			f_mensaje("Error",SQLca.SqlErrText)
		else
			commit;
		end if	
	END IF
	
	f_cargar3()
	
	em_dto3.text               = ""
	em_cantidad3.text          = "0"
	uo_articulo.em_codigo.text = ""
	uo_articulo.em_campo.text  = ""
	st_unidad3.text            = ""
	f_activar_campo(uo_articulo.em_campo)
end if


end event

event getfocus;call super::getfocus;f_activar("3")
end event

type st_5 from statictext within w_con_dto_cliente
integer x = 2523
integer y = 156
integer width = 261
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Calidad:"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_tar1 from u_datawindow_consultas within w_con_dto_cliente
integer y = 260
integer width = 864
integer height = 1236
integer taborder = 0
string dataobject = "dw_con_dto_cliente1"
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;call super::rowfocuschanged;f_cargar2()
end event

event clicked;call super::clicked;This.SetFocus()
IF f_objeto_datawindow(dw_tar1) = "borrar" Then 
	f_borrar1()
	Return
END IF
IF row <> 0 Then
	uo_familia.em_codigo.text    = this.object.familia[row]
	uo_familia.em_campo.text     = this.object.familias_descripcion[row]
	uo_familia.ue_valor_anterior = uo_familia.em_campo.text 
	em_dto1.text                 = String(this.object.dto[row])
	em_cantidad1.text            = String(this.object.cantidad[row])
	uo_unidad1.em_codigo.text    = this.object.unidad[row]
	uo_unidad1.em_campo.text     = this.object.unidades_abreviado[row]
	f_activar_campo(uo_familia.em_campo)
END IF


end event

event getfocus;call super::getfocus;f_activar_campo(uo_familia.em_campo)
end event

type dw_tar3 from u_datawindow_consultas within w_con_dto_cliente
integer x = 1906
integer y = 256
integer width = 1531
integer height = 1236
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_con_dto_cliente2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;This.SetFocus()
IF f_objeto_datawindow(dw_tar3) = "borrar" Then 
	f_borrar3()
	Return
END IF

IF row <> 0 Then
	uo_articulo.em_codigo.text   = this.object.articulo[row]
	uo_articulo.em_campo.text    = this.object.articulos_descripcion[row]
	uo_articulo.ue_valor_anterior = 	uo_articulo.em_campo.text 
	em_dto3.text                 = String(this.object.dto[row])
	em_cantidad3.text            = String(this.object.cantidad[row])
	st_unidad3.text              = f_nombre_unidad_abr(this.object.articulos_unidad[row])

	f_activar_campo(uo_articulo.em_campo)
END IF

end event

event getfocus;call super::getfocus;f_activar_campo(uo_articulo.em_campo)
end event

type cb_borrar from u_boton within w_con_dto_cliente
event clicked pbm_bnclicked
boolean visible = false
integer x = 2345
integer y = 164
integer width = 315
integer height = 76
integer taborder = 0
string text = "F3 Borrar"
end type

event clicked;call super::clicked;IF MessageBox("Este proceso borrara todos los Dtos. A este cliente","Desea continuar?",Question!,YesNo!) = 1 Then
	String cliente
  cliente = uo_cliente.em_codigo.text
  
   DELETE FROM vendtoartcli  
   WHERE vendtoartcli.empresa = :codigo_empresa 
	AND   vendtoartcli.cliente = :cliente;
	
	DELETE FROM vendtofamcli  
   WHERE vendtofamcli.empresa = :codigo_empresa
	AND   vendtofamcli.cliente = :cliente;
	
	DELETE FROM vendtofamforcli  
   WHERE vendtofamforcli.empresa = :codigo_empresa 
	AND   vendtofamforcli.cliente = :cliente;

	COMMIT;
	dw_tar1.reset()
	dw_tar2.reset()
	dw_tar3.reset()
END IF
end event

type cb_continuar from u_boton within w_con_dto_cliente
integer x = 1888
integer y = 160
integer width = 393
integer height = 76
integer taborder = 140
string text = "F5 Continuar"
end type

event clicked;//f_cargar1()
//f_activar_campo(uo_familia.em_campo)
f_cargar2()
f_activar_campo(uo_articulo.em_campo)
end event

type dw_tar2 from u_datawindow_consultas within w_con_dto_cliente
event clicked pbm_dwnlbuttonclk
event editchanged pbm_dwnchanging
event rowfocuschanged pbm_dwnrowchange
event key pbm_dwnkey
integer x = 869
integer y = 260
integer width = 1024
integer height = 1236
integer taborder = 0
string dataobject = "dw_con_dto_cliente3"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;This.SetFocus()
IF f_objeto_datawindow(dw_tar2) = "borrar" Then
	f_borrar2()
	Return
END IF
IF row <> 0 Then
	uo_formato.em_codigo.text    = this.object.formato[row]
	uo_formato.em_campo.text     = this.object.formatos_descripcion[row]
	uo_formato.ue_valor_anterior = 	uo_formato.em_campo.text 
	em_dto2.text                 = String(this.object.dto[row])
	em_cantidad2.text            = String(this.object.cantidad[row])
	uo_unidad2.em_codigo.text    = this.object.unidad[row]
	uo_unidad2.em_campo.text     = this.object.unidades_abreviado[row]	
	f_activar_campo(uo_formato.em_campo)
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;f_cargar3()
end event

event getfocus;call super::getfocus;f_activar_campo(uo_formato.em_campo)
end event

type uo_formato from u_em_campo_2 within w_con_dto_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 887
integer y = 1624
integer width = 983
integer height = 72
integer taborder = 60
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_formato.em_campo.text=f_nombre_formato_abr(codigo_empresa,uo_formato.em_codigo.text)
If Trim(uo_formato.em_campo.text)="" then
	uo_formato.em_campo.text=""
	uo_formato.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Formatos"
ue_datawindow ="dw_ayuda_formatos"
f_activar("2")
end event

on uo_formato.destroy
call u_em_campo_2::destroy
end on

type em_dto2 from u_em_campo within w_con_dto_cliente
event tecla_enter pbm_custom03
integer x = 1650
integer y = 1704
integer width = 137
integer height = 72
integer taborder = 90
end type

event tecla_enter;call super::tecla_enter;String   v_cliente,cod_familia,v_calidad,cod_formato,v_unidad
DateTime fecha
Dec      v_cantidad,v_dto,numero


fecha = DateTime(Today(),Now())
cod_familia = dw_tar1.object.familia[dw_tar1.GetRow()]
cod_formato = uo_formato.em_codigo.text
v_unidad    = uo_unidad2.em_codigo.text
v_cliente   = uo_cliente.em_codigo.text
v_calidad   = uo_calidad.em_codigo.text
v_dto       = Dec(em_dto2.text)
v_cantidad  = Dec(em_cantidad2.text)

IF IsNull(cod_formato) Or Trim(cod_formato) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca el formato")
	f_activar_campo(uo_formato.em_campo)
	Return
END IF
IF IsNull(v_unidad) Or Trim(v_unidad) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca la unidad")
	f_activar_campo(uo_unidad2.em_campo)
	Return
END IF

Select Count(*) 
Into   :numero 
From   vendtofamforcli
Where  empresa  = :codigo_empresa
And    cliente  = :v_cliente
And    familia  = :cod_familia
And    formato  = :cod_formato
And    calidad  = :v_calidad
And    unidad   = :v_unidad
And    cantidad = :v_cantidad;
IF IsNull(numero) Then numero = 0
IF numero = 0 Then
	INSERT INTO vendtofamforcli  
		(empresa,			cliente,			familia,
		 formato,			calidad,			dto,
		 cantidad,			unidad,			falta,
		 usuario )  
	VALUES 
		(:codigo_empresa,	:v_cliente,		:cod_familia,
		 :cod_formato,		:v_calidad,   	:v_dto,
		 :v_cantidad,		:v_unidad,		:fecha,
		 :nombre_usuario );
		 
	iF SQLCA.SQLCODE <> 0 Then 
		rollback;
		f_mensaje("Error",SQLca.SqlErrText)
	else
		commit;
	end if		 
ELSE
	Update  vendtofamforcli  
	Set     dto = :v_dto
	Where   empresa  = :codigo_empresa
	And     cliente  = :v_cliente
	And     familia  = :cod_familia
	And     formato  = :cod_formato
	And     calidad  = :v_calidad
	And     cantidad = :v_cantidad
	And     unidad   = :v_unidad;
	
	iF SQLCA.SQLCODE <> 0 Then 
		rollback;
		f_mensaje("Error",SQLca.SqlErrText)
	else
		commit;
	end if	
END IF

f_cargar2()

em_dto2.text              = ""
em_cantidad2.text         = "0"
uo_formato.em_codigo.text = ""
uo_formato.em_campo.text  = ""
uo_unidad2.em_codigo.text = ""
uo_unidad2.em_campo.text  = ""

f_activar_campo(uo_formato.em_campo)

end event

event getfocus;call super::getfocus;f_activar("2")
end event

type st_42 from statictext within w_con_dto_cliente
integer x = 887
integer y = 1560
integer width = 983
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Formato"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad2 from u_em_campo within w_con_dto_cliente
event tecla_enter pbm_custom03
integer x = 1138
integer y = 1704
integer width = 219
integer height = 72
integer taborder = 70
integer weight = 400
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

event getfocus;call super::getfocus;f_activar("2")
end event

type em_cantidad3 from u_em_campo within w_con_dto_cliente
event tecla_enter pbm_custom03
integer x = 2176
integer y = 1700
integer width = 306
integer height = 72
integer taborder = 110
integer weight = 400
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

event getfocus;call super::getfocus;f_activar("3")
end event

type uo_familia from u_em_campo_2 within w_con_dto_cliente
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 14
integer y = 1624
integer width = 837
integer height = 72
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_familia.em_campo.text=f_nombre_familia(codigo_empresa,uo_familia.em_codigo.text)
If Trim(uo_familia.em_campo.text)="" then
	uo_familia.em_campo.text=""
	uo_familia.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo     = "Selección de Familias"
ue_datawindow = "dw_ayuda_familias"
ue_filtro     = "sector = 'S'"
f_activar("1")
end event

on uo_familia.destroy
call u_em_campo_2::destroy
end on

type em_dto1 from u_em_campo within w_con_dto_cliente
event tecla_enter pbm_custom03
integer x = 713
integer y = 1704
integer width = 137
integer height = 72
integer taborder = 50
end type

event tecla_enter;call super::tecla_enter;String   v_cliente,cod_familia,v_calidad,v_unidad
DateTime fecha
fecha = DateTime(Today(),Now())
Dec     v_cantidad,v_dto,numero

cod_familia = uo_familia.em_codigo.text
v_unidad    = uo_unidad1.em_codigo.text
v_calidad   = uo_calidad.em_codigo.text
v_cliente   = uo_cliente.em_codigo.text
v_dto       = Dec(em_dto1.text)
v_cantidad  = Dec(em_cantidad1.text)

IF IsNull(cod_familia) Or Trim(cod_familia) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca la familia")
	f_activar_campo(uo_familia.em_campo)
	Return
END IF
IF IsNull(v_unidad) Or Trim(v_unidad) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca la unidad")
	f_activar_campo(uo_unidad1.em_campo)
	Return
END IF
IF IsNull(v_unidad) Or Trim(v_unidad) = "" Then
	f_mensaje("Campo Obligatorio","Introduzca la unidad")
	f_activar_campo(uo_unidad1.em_campo)
	Return
END IF

Select  Count(*) 
Into    :numero 
From    vendtofamcli
Where   empresa  = :codigo_empresa
And     cliente  = :v_cliente
And     familia  = :cod_familia
And     calidad  = :v_calidad
And     unidad   = :v_unidad
And     cantidad = :v_cantidad;
IF IsNull(numero) Then numero = 0
IF numero = 0 Then
	INSERT INTO vendtofamcli  
		(empresa,			cliente,			familia,
		 calidad,			dto,				cantidad,
		 unidad,				falta,			usuario)  
	VALUES 
		(:codigo_empresa,	:v_cliente,		:cod_familia,
		 :v_calidad,   	:v_dto,			:v_cantidad,
		 :v_unidad,			:fecha,			:nombre_usuario);
	iF SQLCA.SQLCODE <> 0 Then 
		rollback;
		f_mensaje("Error",SQLca.SqlErrText)
	else
		commit;
	end if
ELSE
	Update  vendtofamcli  
	Set     dto = :v_dto
	Where   empresa  = :codigo_empresa
	And     cliente  = :v_cliente
	And     familia  = :cod_familia
	And     calidad  = :v_calidad
	And     unidad   = :v_unidad
	And     cantidad = :v_cantidad;
	
	iF SQLCA.SQLCODE <> 0 Then 
		rollback;
		f_mensaje("Error",SQLca.SqlErrText)
	else
		commit;
	end if
	
END IF

f_cargar1()

em_dto1.text              = ""
em_cantidad1.text         = "0"
uo_familia.em_codigo.text = ""
uo_familia.em_campo.text  = ""
uo_unidad1.em_codigo.text = ""
uo_unidad1.em_campo.text  = ""

f_activar_campo(uo_familia.em_campo)

end event

event getfocus;call super::getfocus;f_activar("1")
end event

type st_41 from statictext within w_con_dto_cliente
integer x = 14
integer y = 1560
integer width = 837
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Familia"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_dto1 from statictext within w_con_dto_cliente
integer x = 603
integer y = 1712
integer width = 110
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Dto :"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_cantidad1 from u_em_campo within w_con_dto_cliente
event tecla_enter pbm_custom03
integer x = 261
integer y = 1704
integer width = 219
integer height = 72
integer taborder = 30
integer weight = 400
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,##0"
end type

event getfocus;call super::getfocus;f_activar("1")
end event

type gb_5 from groupbox within w_con_dto_cliente
integer x = 2501
integer y = 120
integer width = 773
integer height = 136
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_4 from groupbox within w_con_dto_cliente
integer x = 9
integer y = 112
integer width = 2304
integer height = 140
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_con_dto_cliente
integer x = 3291
integer y = 4
integer width = 114
integer height = 104
integer taborder = 0
end type

type pb_3 from upb_imprimir within w_con_dto_cliente
integer x = 3287
integer y = 152
integer taborder = 10
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
f_activar_campo(uo_cliente.em_campo)

end event

type uo_unidad1 from u_em_campo_2 within w_con_dto_cliente
event destroy ( )
integer x = 480
integer y = 1704
integer width = 114
integer height = 72
integer taborder = 40
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_unidad1.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = f_nombre_unidad_abr(this.em_codigo.text)
If Trim(this.em_campo.text)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;valor_empresa = false
ue_titulo     = "Selección de Unidades"
ue_datawindow = "dw_ayuda_unidades"
ue_filtro     = ""
end event

type st_cantidad1 from statictext within w_con_dto_cliente
integer x = 14
integer y = 1660
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad :"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_con_dto_cliente
integer y = 1516
integer width = 864
integer height = 276
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_cantidad2 from statictext within w_con_dto_cliente
integer x = 891
integer y = 1712
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad :"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_unidad2 from u_em_campo_2 within w_con_dto_cliente
event destroy ( )
integer x = 1358
integer y = 1704
integer width = 114
integer height = 72
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_unidad2.destroy
call u_em_campo_2::destroy
end on

event modificado;this.em_campo.text = f_nombre_unidad_abr(this.em_codigo.text)
If Trim(this.em_campo.text)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;valor_empresa = false
ue_titulo     = "Selección de Unidades"
ue_datawindow = "dw_ayuda_unidades"
ue_filtro     = ""
end event

type st_dto2 from statictext within w_con_dto_cliente
integer x = 1541
integer y = 1712
integer width = 110
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Dto :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_cantidad3 from statictext within w_con_dto_cliente
integer x = 1920
integer y = 1708
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cantidad :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_dto3 from statictext within w_con_dto_cliente
integer x = 3081
integer y = 1708
integer width = 110
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Dto :"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_con_dto_cliente
integer x = 1906
integer y = 1512
integer width = 1531
integer height = 276
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type st_unidad3 from statictext within w_con_dto_cliente
integer x = 2491
integer y = 1700
integer width = 114
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_dto_cliente
integer x = 1920
integer y = 1556
integer width = 1504
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_con_dto_cliente
integer x = 873
integer y = 1516
integer width = 1010
integer height = 276
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

