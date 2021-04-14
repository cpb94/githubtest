$PBExportHeader$w_cambia_documentos.srw
forward
global type w_cambia_documentos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_cambia_documentos
end type
type cb_1 from commandbutton within w_cambia_documentos
end type
end forward

global type w_cambia_documentos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2880
integer height = 1540
string title = "Consulta de Movimientos"
pb_2 pb_2
cb_1 cb_1
end type
global w_cambia_documentos w_cambia_documentos

type variables
String ante_articulo,retrasos,isle_campo
end variables

on w_cambia_documentos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_1
end on

on w_cambia_documentos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cambia_documentos
integer x = 23
integer y = 1016
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cambia_documentos
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cambia_documentos
integer y = 20
integer width = 2642
integer height = 92
end type

type pb_2 from upb_salir within w_cambia_documentos
integer x = 2734
integer y = 12
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_1 from commandbutton within w_cambia_documentos
integer x = 2043
integer y = 224
integer width = 306
integer height = 108
integer taborder = 1
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "PELIGRO"
end type

event clicked;string sel,doc_anterior,nuevo
datastore d

int i,j,num_tablas

string nombre[]

nombre[1] = "carforpag"
nombre[2] = "carpagos"
//nombre[3] = "carpagos_plantillas"
//nombre[4] = "carpagosparam"
nombre[3] = "carefectos"
nombre[4] = "carhistorico"
//nombre[5] = "carremesas"
//nombre[6] = "carbangas"
//nombre[7] = "carlbangas"

num_tablas = 4

for j = 1 to num_tablas

	sel = "select * " +&
			" from " + nombre[j] 
	//d= f_cargar_cursor(sel)
	f_cargar_cursor_nuevo(sel, d)
	
	
	for i = 1 to d.rowcount()
		doc_anterior = d.getitemstring(i,"tipodoc")
		choose case doc_anterior
			
			case "1"
				//setitem(i,"tipodoc","7")
				//nuevo = "2"
			case "2"
				//setitem(i,"tipodoc","6")
				nuevo = "3"			
			
			string c1,c2,c3,c4,c5
			dec d1,d2,d3
			int i1,i2
			
			
			c1 = d.getitemstring(i,"empresa")
			choose case nombre[j]
			
				case "carforpag"
					c2 = d.getitemstring(i,"forma")
					
					update carforpag
					set tipodoc = :nuevo
					where carforpag.empresa = :c1  and
							carforpag.forma = :c2;
					
					
				case "carpagos"
					d1 = d.getitemnumber(i,"anyo")
					d2 = d.getitemnumber(i,"orden")
					update carpagos
					set tipodoc = :nuevo
					where carpagos.empresa = :c1 and
							carpagos.anyo = :d1		and
							carpagos.orden = :d2;
			
			
				case "carefectos"
					d1 = d.getitemnumber(i,"anyo")
					d2 = d.getitemnumber(i,"orden")
					
					update carefectos 
					set tipodoc = :nuevo
					where carefectos.empresa = :c1 and
							carefectos.anyo = :d1		and
							carefectos.orden = :d2;
			
				case "carhistorico"
					d1 = d.getitemnumber(i,"anyo")
					d2 = d.getitemnumber(i,"orden")
					d3 = d.getitemnumber(i,"linea")
			
					update carhistorico 
					set tipodoc = :nuevo
					where carhistorico.empresa = :c1 and
							carhistorico.anyo = :d1		and
							carhistorico.orden = :d2 	and
							carhistorico.linea = :d3;
				case "carremesas"
					d1 = d.getitemnumber(i,"anyo")
					c2 = d.getitemstring(i,"banco")
					c3 = d.getitemstring(i,"naci_extra")
					d2 = d.getitemnumber(i,"remesa")
					
					update carremesas
						set tipodoc = :nuevo
						where carremesas.empresa = :c1	and
								carremesas.anyo = :d1		and
								carremesas.banco = :c2		and
								carremesas.naci_extra = :c3 and
								carremesas.remesa = :d2;
					
			
				case "carbangas"
					c2 = d.getitemstring(i,"banco")
					c3 = d.getitemstring(i,"tipodoc")
					c4 = d.getitemstring(i,"naciextra")
			
					update carbangas
						set tipodoc = :nuevo
						where carbangas.empresa = :c1	and
								carbangas.banco = :c2		and
								carbangas.tipodoc = :c3	and
								carbangas.naciextra = :c4 ;
			
			
				case "carlbangas"
					c2 = d.getitemstring(i,"banco")
					c3 = d.getitemstring(i,"tipodoc")
					c4 = d.getitemstring(i,"naciextra")
					c5 = d.getitemstring(i,"gasto")
					
					update carlbangas
						set tipodoc = :nuevo
						where carlbangas.empresa = :c1	and
								carlbangas.banco = :c2		and
								carlbangas.tipodoc = :c3	and
								carlbangas.naciextra = :c4 and
								carlbangas.gasto = :c5;
					
				end choose
	
			case "3"
				//setitem(i,"tipodoc","3")
				//nuevo = "7"
			case "4"
				//setitem(i,"tipodoc","5")
				//nuevo = "1"
			case "5"
				//setitem(i,"tipodoc","10")
				//nuevo = "20"
			case "6"
				//setitem(i,"tipodoc","4")
				//nuevo = "21"
			case "7"
				//setitem(i,"tipodoc","8")
				//nuevo = "10"
			case "8"
				//setitem(i,"tipodoc","1")
				//nuevo = "22"
			case "9"
				//setitem(i,"tipodoc","9")
				//nuevo = "23"
			case "10"
				//setitem(i,"tipodoc","14")
				//nuevo = "6"
			
		case else
			messagebox(nombre[j],doc_anterior)
		end choose
		

		
	next
	int op
	op = messagebox(nombre[j],"",question!,yesno!,2)
	
	if op = 1 then
		commit;
	else
		rollback;
	end if
	
next	
destroy d
end event

