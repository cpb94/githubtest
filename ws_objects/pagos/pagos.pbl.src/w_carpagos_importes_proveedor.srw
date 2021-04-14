$PBExportHeader$w_carpagos_importes_proveedor.srw
forward
global type w_carpagos_importes_proveedor from w_int_con_empresa
end type
type pb_2 from upb_salir within w_carpagos_importes_proveedor
end type
type cb_consulta from u_boton within w_carpagos_importes_proveedor
end type
type pb_imprimir_preli from picturebutton within w_carpagos_importes_proveedor
end type
type uo_tipo2 from u_marca_lista within w_carpagos_importes_proveedor
end type
type gb_2 from groupbox within w_carpagos_importes_proveedor
end type
type dw_1 from datawindow within w_carpagos_importes_proveedor
end type
type st_1 from statictext within w_carpagos_importes_proveedor
end type
type uo_proveedor from u_em_campo_2 within w_carpagos_importes_proveedor
end type
type gb_cuenta from groupbox within w_carpagos_importes_proveedor
end type
end forward

global type w_carpagos_importes_proveedor from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 6638
integer height = 2124
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
uo_tipo2 uo_tipo2
gb_2 gb_2
dw_1 dw_1
st_1 st_1
uo_proveedor uo_proveedor
gb_cuenta gb_cuenta
end type
global w_carpagos_importes_proveedor w_carpagos_importes_proveedor

type variables
String situaciond,situacionh
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_cargar (datawindow dw_data)
end prototypes

public function string f_filtro ();return ""
end function

public subroutine f_cargar (datawindow dw_data);
String sel, modificar, nombre_mes, proveedor, proveedor_des, cuenta, filtro_proveedor
datastore reg
int mes_actual, anyo_actual,mes,anyo,i, meses_dif
datetime fecha, fecha_actual, fecha_primer_efecto
decimal importe, importe_total
long fila


dw_1.reset()

dw_1.SetTransObject(sqlca)

if uo_proveedor.em_codigo.text = "" or isnull(uo_proveedor.em_codigo.text) then
	filtro_proveedor = "%"
else
	filtro_proveedor = uo_proveedor.em_codigo.text
end if

//Primero relleno la cabecera con los meses

select month(getdate()), year(getdate())
into :mes_actual, :anyo_actual
from empresas
where empresa =:codigo_empresa
using sqlca;

fecha_actual = datetime("01-"+String(mes_actual)+"-"+String(anyo_actual))

mes = mes_actual

for i = 1 to 12
	
	fecha = datetime("01-"+String(mes)+"-2020")
	select DATENAME (MONTH,:fecha)
	into :nombre_mes
	from empresas
	where empresa = :codigo_empresa
	using sqlca;
	
	modificar = "mes_" + String(i)
	dw_1.Modify (modificar+".Text = '"+nombre_mes+"'" )
	
	if mes = 12 then
		mes = 1
	else
		mes +=1
	end if
next


//Primer efecto sin pagar
select top 1 carpagos.fvto
into :fecha_primer_efecto
from carpagos
where carpagos.empresa = :codigo_empresa
and carpagos.situacion <> '2'
and carpagos.inmovilizado = 'S'
order by fvto asc;


//Después los datos

sel = 	" select tabla.mes as mes,  "+&
        	" tabla.anyo as anyo,  "+&
		" tabla.proveedor as carpagos_proveedor,  "+&
	   	" tabla.razon as genter_razon, "+&
        	" tabla.cuenta as carpagos_cuenta,   "+&
        	" sum(tabla.importe) as importe "+&
		" from "+&
		"	(select		"+&
		"			carpagosdetagrupado.orden as orden_agrupada, "+&
		"			carpagosdetagrupado.anyo as anyo_agrupado, "+&
		"			carpagos.agrupado, "+&
		"			carpagos.orden, "+&
		"			month(carpagos.fvto) as mes, "+&
		"			year(carpagos.fvto) as anyo,  "+&
		"			carpagos.proveedor, "+&
		"			genter.razon, "+&
		"			carpagos.cuenta, "+&
		"			CASE WHEN carpagos.agrupado = 'N' THEN "+&
		"					sum(carpagos.importe)  "+&
		"				 ELSE "+&
		"					sum(carpagosdetagrupado.importe) "+&
		"			END as importe "+&
		"			from   carpagos "+&
		"			inner join genter on genter.empresa = carpagos.empresa and genter.codigo = carpagos.proveedor and genter.tipoter = 'P' "+&
		"			left join carpagosdetagrupado on carpagosdetagrupado.empresa = carpagos.empresa and carpagosdetagrupado.anyo_agrupado = carpagos.anyo and carpagosdetagrupado.orden_agrupado = carpagos.orden "+&
		"   			where  (month(carpagos.fvto) >= month('"+String(date(fecha_primer_efecto))+"') and year(carpagos.fvto) = year('"+String(date(fecha_primer_efecto))+"') or (month(carpagos.fvto) < month('"+String(date(fecha_primer_efecto))+"') and year(carpagos.fvto) = year('"+String(date(fecha_primer_efecto))+"') + 1)) "+& 
		"			and carpagos.empresa = '"+codigo_empresa+"' "+&
		"			and CASE "+&
		"					WHEN carpagos.agrupado = 'N' "+&
		"						THEN carpagos.cuenta "+&
		"					ELSE "+&
		"						carpagosdetagrupado.cuenta  "+&
		"				END like  '523%' "+&
		"			and carpagos.situacion <> '2' "+&
		"   			and carpagos.proveedor like '"+filtro_proveedor+"' "+&
		"			group by carpagos.proveedor, "+&
		"			genter.razon, "+&
		"			carpagos.cuenta, "+&
		"			month(carpagos.fvto), "+& 
		"			year(carpagos.fvto) , "+&
		"			carpagos.agrupado, "+&
		"			carpagos.orden, "+&
		"			carpagosdetagrupado.anyo, "+&
		"			carpagosdetagrupado.orden "+&
		"			/* "+&
		"			order by carpagos.proveedor,  "+&
		"			genter.razon, "+&
		"			carpagos.cuenta, "+&
		"			year(carpagos.fvto), "+& 
		"			month(carpagos.fvto) "+&
		"			*/ 		"+&
		"	) as tabla "+&
		" group by tabla.proveedor,  "+&
		"		 tabla.razon, "+&
		"		 tabla.cuenta, "+&
		"		 tabla.mes, "+&
		"		 tabla.anyo "

/* Modificamos la consulta para añadir los efectos agrupados que no están marcados con inmovilizados

sel =  "	select	month(carpagos.fvto) as mes, "+&
         "   year(carpagos.fvto) as anyo, "+&
         "   carpagos.proveedor, "+&
		"	genter.razon, "+&
         "   carpagos.cuenta, "+&
         "   sum(carpagos.importe) as importe "+&
		"	from   carpagos "+&
		"	inner join genter on genter.empresa = carpagos.empresa and genter.codigo = carpagos.proveedor and genter.tipoter = 'P' "+&
		"   where  (month(carpagos.fvto) >= month('"+String(date(fecha_primer_efecto))+"') and year(carpagos.fvto) = year('"+String(date(fecha_primer_efecto))+"') or (month(carpagos.fvto) < month('"+String(date(fecha_primer_efecto))+"') and year(carpagos.fvto) = year('"+String(date(fecha_primer_efecto))+"') + 1)) "+&
        	"	and carpagos.empresa = '"+codigo_empresa+"' "+&
		"	and carpagos.inmovilizado = 'S' "+&
		"   and carpagos.situacion <> '2' "+&
		"   and carpagos.proveedor like '"+filtro_proveedor+"' "+&
		"	group by	carpagos.proveedor, "+&
		"	genter.razon, "+&
         "   carpagos.cuenta, "+&
         "   month(carpagos.fvto), "+&
         "   year(carpagos.fvto) "+&
		"	order by	carpagos.proveedor, "+&
		"	genter.razon, "+&
         "   carpagos.cuenta, "+&
		"	year(carpagos.fvto), "+&
         "   month(carpagos.fvto)"
			
	*/

/*En Lugar de coger la fecha actual como referencia, cogemos la fecha del primer efecto que no esté pagado (<> 2) 

sel =  "	select	month(carpagos.fvto) as mes, "+&
         "   year(carpagos.fvto) as anyo, "+&
         "   carpagos.proveedor, "+&
		"	genter.razon, "+&
         "   carpagos.cuenta, "+&
         "   sum(carpagos.importe) as importe "+&
		"	from   carpagos "+&
		"	inner join genter on genter.empresa = carpagos.empresa and genter.codigo = carpagos.proveedor and genter.tipoter = 'P' "+&
		"   where  (month(carpagos.fvto) >= month(getdate()) and year(carpagos.fvto) = year(getdate()) or (month(carpagos.fvto) < month(getdate()) and year(carpagos.fvto) = year(getdate()) + 1)) "+&
        	"	and carpagos.empresa = '"+codigo_empresa+"' "+&
		"	and carpagos.inmovilizado = 'S' "+&
		"   and carpagos.situacion <> '2' "+&
		"	group by	carpagos.proveedor, "+&
		"	genter.razon, "+&
         "   carpagos.cuenta, "+&
         "   month(carpagos.fvto), "+&
         "   year(carpagos.fvto) "+&
		"	order by	carpagos.proveedor, "+&
		"	genter.razon, "+&
         "   carpagos.cuenta, "+&
		"	year(carpagos.fvto), "+&
         "   month(carpagos.fvto)"
			
*/			

f_cargar_cursor_transaccion(sqlca, reg, sel )

for i = 1 to reg.rowcount()
	
	mes = reg.object.mes[i] 
	
	anyo = reg.object.anyo[i]
	
	proveedor = reg.object.carpagos_proveedor[i]
	
	proveedor_des = reg.object.genter_razon[i]
	
	cuenta = reg.object.carpagos_cuenta[i]
	
	importe = reg.object.importe[i]
	
	fila = dw_1.Find ("proveedor = '"+proveedor+"'",1,dw_1.RowCount())
	
	if fila = 0 then fila = dw_1.insertrow(0)
	
	fecha = datetime("01-"+String(mes)+"-"+String(anyo))
	
	select DATEDIFF(month,:fecha_actual,:fecha)
	into :meses_dif
	from empresas
	where empresa = :codigo_empresa;
	
	choose case meses_dif
			
		case 0
			dw_1.object.imp_mes_1[fila] = importe
		case 1
			dw_1.object.imp_mes_2[fila] = importe
		case 2
			dw_1.object.imp_mes_3[fila] = importe
		case 3
			dw_1.object.imp_mes_4[fila] = importe
		case 4
			dw_1.object.imp_mes_5[fila] = importe
		case 5
			dw_1.object.imp_mes_6[fila] = importe
		case 6
			dw_1.object.imp_mes_7[fila] = importe
		case 7
			dw_1.object.imp_mes_8[fila] = importe
		case 8
			dw_1.object.imp_mes_9[fila] = importe
		case 9
			dw_1.object.imp_mes_10[fila] = importe
		case 10
			dw_1.object.imp_mes_11[fila] = importe
		case 11
			dw_1.object.imp_mes_12[fila] = importe
	end choose
	
	dw_1.object.proveedor_des[fila] = proveedor_des
	dw_1.object.cuenta[fila] = cuenta
	dw_1.object.proveedor[fila] = proveedor
	
	
	select sum(
			CASE WHEN carpagos. agrupado = 'N' THEN
					carpagos.importe
				ELSE
					carpagosdetagrupado.importe				
			END) as importe
	into :importe_total
	from carpagos
	left join carpagosdetagrupado on carpagosdetagrupado.empresa = carpagos.empresa and carpagosdetagrupado.anyo_agrupado = carpagos.anyo and carpagosdetagrupado.orden_agrupado = carpagos.orden 
	where carpagos.empresa = :codigo_empresa
	and CASE 
				WHEN carpagos.agrupado = 'N' 
						THEN 
							carpagos.cuenta
						ELSE
							carpagosdetagrupado.cuenta 
				END like  '523%'
	and CASE 
				WHEN carpagos.agrupado = 'N' 
						THEN 
							carpagos.fvto
						ELSE
							carpagosdetagrupado.fvto 
				END >= :fecha_primer_efecto
	and carpagos.situacion <> '2'
	and carpagos.proveedor = :proveedor
	using sqlca;
	
	dw_1.object.imp_total[fila] = importe_total
	
next


end subroutine

event open;call super::open;String mascara
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA PAGOS INMOVILIZADO POR PROVEEDOR"

end event

on w_carpagos_importes_proveedor.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_tipo2=create uo_tipo2
this.gb_2=create gb_2
this.dw_1=create dw_1
this.st_1=create st_1
this.uo_proveedor=create uo_proveedor
this.gb_cuenta=create gb_cuenta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.uo_tipo2
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.uo_proveedor
this.Control[iCurrent+9]=this.gb_cuenta
end on

on w_carpagos_importes_proveedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.uo_tipo2)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.uo_proveedor)
destroy(this.gb_cuenta)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_carpagos_importes_proveedor
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_carpagos_importes_proveedor
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_carpagos_importes_proveedor
integer width = 6546
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

type pb_2 from upb_salir within w_carpagos_importes_proveedor
integer x = 6441
integer y = 92
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_carpagos_importes_proveedor
integer x = 6053
integer y = 204
integer width = 293
integer height = 72
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Consulta"
end type

event clicked;call super::clicked;

f_cargar(dw_1)

end event

type pb_imprimir_preli from picturebutton within w_carpagos_importes_proveedor
integer x = 6441
integer y = 192
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
boolean originalsize = true
string picturename = "print!"
end type

event clicked;if dw_1.rowcount() > 0 then
	f_imprimir_datawindow(dw_1)
	//dw_1.print()
end if
end event

type uo_tipo2 from u_marca_lista within w_carpagos_importes_proveedor
boolean visible = false
integer x = 1125
integer y = 332
integer width = 1454
integer height = 652
boolean border = false
end type

on uo_tipo2.destroy
call u_marca_lista::destroy
end on

type gb_2 from groupbox within w_carpagos_importes_proveedor
integer x = 6034
integer y = 160
integer width = 325
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_1 from datawindow within w_carpagos_importes_proveedor
integer y = 320
integer width = 6574
integer height = 1612
boolean bringtotop = true
string dataobject = "dw_carpagos_importes_proveedor"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within w_carpagos_importes_proveedor
integer x = 23
integer y = 144
integer width = 1435
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

type uo_proveedor from u_em_campo_2 within w_carpagos_importes_proveedor
event destroy ( )
integer x = 27
integer y = 200
integer width = 1431
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)
If Trim(uo_proveedor.em_campo.text)="" then
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
	Return
end if 

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"

end event

type gb_cuenta from groupbox within w_carpagos_importes_proveedor
integer x = 5
integer y = 88
integer width = 1472
integer height = 216
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

