$PBExportHeader$w_uticontrol_campos.srw
forward
global type w_uticontrol_campos from w_int_con_empresa
end type
type apartados from tab within w_uticontrol_campos
end type
type pagina1 from userobject within apartados
end type
type dw_pagina1 from datawindow within pagina1
end type
type dw_pagina2 from datawindow within pagina1
end type
type pagina1 from userobject within apartados
dw_pagina1 dw_pagina1
dw_pagina2 dw_pagina2
end type
type apartados from tab within w_uticontrol_campos
pagina1 pagina1
end type
type dw_proceso from datawindow within w_uticontrol_campos
end type
end forward

global type w_uticontrol_campos from w_int_con_empresa
integer width = 2802
integer height = 1720
apartados apartados
dw_proceso dw_proceso
end type
global w_uticontrol_campos w_uticontrol_campos

forward prototypes
public subroutine f_control (long id)
end prototypes

public subroutine f_control (long id);Integer  registros,reg,numero
String   var_tabla,var_columna,var_control
registros = dw_proceso.Retrieve(id)
apartados.pagina1.dw_pagina2.Reset()
For reg = 1 To registros
	var_tabla   = f_valor_columna(apartados.pagina1.dw_pagina1,apartados.pagina1.dw_pagina1.GetRow(),"name")
	var_columna = f_valor_columna(dw_proceso,reg,"name")
	Select count(*) Into :numero from uticontrolcolumnas
	Where  uticontrolcolumnas.tabla   =  :var_tabla
	And    uticontrolcolumnas.columna =  :var_columna;
	iF IsNull(numero) Then numero = 0
	If numero <> 0 then
		var_control= "S"
	ELSE
		var_control= "N"
	END IF
	apartados.pagina1.dw_pagina2.insertRow(reg)	
	f_asignar_columna(apartados.pagina1.dw_pagina2,reg,"columna",var_columna)
	f_asignar_columna(apartados.pagina1.dw_pagina2,reg,"control",var_control)
NExt
end subroutine

event open;call super::open;dw_proceso.SettransObject(SQLCA)
apartados.pagina1.dw_pagina1.SettransObject(SQLCA)
apartados.pagina1.dw_pagina1.SetRowFocusIndicator(Hand!)

apartados.pagina1.dw_pagina2.SettransObject(SQLCA)
apartados.pagina1.dw_pagina2.SetRowFocusIndicator(Hand!)

apartados.pagina1.dw_pagina1.Retrieve()


end event

on w_uticontrol_campos.create
int iCurrent
call super::create
this.apartados=create apartados
this.dw_proceso=create dw_proceso
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.apartados
this.Control[iCurrent+2]=this.dw_proceso
end on

on w_uticontrol_campos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.apartados)
destroy(this.dw_proceso)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_uticontrol_campos
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_uticontrol_campos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_uticontrol_campos
end type

type apartados from tab within w_uticontrol_campos
integer x = 46
integer y = 164
integer width = 2715
integer height = 1288
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
pagina1 pagina1
end type

on apartados.create
this.pagina1=create pagina1
this.Control[]={this.pagina1}
end on

on apartados.destroy
destroy(this.pagina1)
end on

type pagina1 from userobject within apartados
integer x = 18
integer y = 112
integer width = 2679
integer height = 1160
long backcolor = 79741120
string text = "Tablas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_pagina1 dw_pagina1
dw_pagina2 dw_pagina2
end type

on pagina1.create
this.dw_pagina1=create dw_pagina1
this.dw_pagina2=create dw_pagina2
this.Control[]={this.dw_pagina1,&
this.dw_pagina2}
end on

on pagina1.destroy
destroy(this.dw_pagina1)
destroy(this.dw_pagina2)
end on

type dw_pagina1 from datawindow within pagina1
integer y = 88
integer width = 1230
integer height = 1060
integer taborder = 2
boolean bringtotop = true
string dataobject = "dw_uticontrol_campos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;String var_id
var_id = f_valor_columna(this,This.GetRow(),"id")
f_control(Dec(var_id))
end event

type dw_pagina2 from datawindow within pagina1
integer x = 1239
integer y = 84
integer width = 1440
integer height = 1060
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_uticontrol_campos2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;String var_columna,var_tabla
var_tabla = f_valor_columna(apartados.pagina1.dw_pagina1,apartados.pagina1.dw_pagina1.GetRow(),"name")
var_columna = f_valor_columna(This,This.GetRow(),"columna")
IF f_valor_columna(This,This.GetRow(),"control") = "S" Then
   Delete from uticontrolcolumnas
	Where empresa=:codigo_empresa
	And   tabla  =:var_tabla
	And   columna=:var_columna;
	COMMIT;
	f_asignar_columna(This,This.GetRow(),"control","N")
ELSE
	  INSERT INTO uticontrolcolumnas  
         ( empresa,   
           tabla,   
           columna )  
  VALUES ( :codigo_empresa,   
           :var_tabla,   
           :var_columna )  ;
			  COMMIT;

	f_asignar_columna(This,This.GetRow(),"control","S")
END IF
end event

event getfocus;apartados.pagina1.dw_pagina1.SetFocus()
end event

type dw_proceso from datawindow within w_uticontrol_campos
boolean visible = false
integer x = 2272
integer y = 20
integer width = 494
integer height = 76
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_uticontrol_campos3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

