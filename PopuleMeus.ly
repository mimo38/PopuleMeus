\version "2.18.2"
\language "italiano"

\header {
   title = "Pópule meus"
  subtitle = "Pour la fonction liturgique solennelle du Vendredi Saint"
  composer = "Abbé Jean Robin († 2002)"
  arranger = "Pâques 1949"
  % Supprimer le pied de page par défaut
  tagline = ##f
  % Supprimer le pied de page par défaut
  tagline = ##f
}

\paper {
  #(set-paper-size "a5")
}
guidon = {\teeny \hide Staff.Stem}
coupe = \bar ""
guidonoff = \undo \guidon

global = {
  \key do \major
  \time 2/2
  \autoBeamOff
}

soprano = \relative do' {
  \global
  % En avant la musique !
  do2^\mf re4 mi mi2 (re2) mi1 \breathe sol2 sol4 sol4 fa2 mi2 \fermata
  la4.^\ff la8 la4 la8 la8 sib2 (la4) sol la1 \fermata
  la2^\mf^\> sol4 fa mi2 re2\! \bar "||"\break
  \cadenzaOn
  re \breve re2 re\breathe \coupe re\breve \coupe re8 do re mi fa [sol] sol4\fermata
  
  \guidon{sol8 fa (mi) fa \bar"||" }
  \guidonoff
 fa \breve 
 
 \coupe mi2 re\breathe 
\coupe re\breve 
 re2 
 \coupe re \breve 
  re4. re8 re2 
 
 \coupe re\breve 
 re8 do re  mi fa [sol] sol4\fermata
\bar "|."
}

alto = \relative do' {
  \global
  % En avant la musique !
  do2 re4 mi do2 (la2) do1 si2 si4 si re2 do
  do4. do8 re4 re8 re re2. re4 dod1
  re2 re4 re do4 (sib) la2
  sib\breve  do2 sib sib\breve la8 la la la do4 sib \bar "||"
    \guidon{sol'8 fa (mi) fa}\guidonoff
  re\breve  do4 sib la2 la\breve la2 sib\breve do4. do8 sib2 sib\breve
  la8 la la la do4 sib

}

tenor = \relative do {
  \global
  % En avant la musique !
  do2 re4 mi sol2 (fa2) sol1 \breathe sol2 sol4 sol la2 la \fermata
  la4. la8 fa4 fa8 fa sol2. sol4 mi1 fa2 sol4 la sol2 fa
  fa\breve fa2 fa2 \breathe fa\breve  mi8 mi fa sol sol4 sol
    \guidon{sol8 fa (mi) fa}\guidonoff
      la\breve sol2 fa2 \breathe fa\breve fa2 fa\breve fa4. fa8 fa2 fa\breve
      mi8 mi fa sol sol4 sol


}

bass = \relative do {
  \global
  % En avant la musique !
do2 re4 mi do1 do mi2  mi4 mi re2 la2 la4. la8 re4 re8 re sol,2 (la4) sib la1 re4 (do) sib la do2 re
sib\breve la2 sol sol\breve la8 la la la la4 sol
  \guidon{sol'8 fa (mi) fa}\guidonoff
  re\breve re2 re2 re\breve do2
  sib\breve la4. la8 sol2 sol\breve
   la8 la la la la4 sol

}

verse = \lyricmode {
  % Ajouter ici des paroles.
Pó -- pu -- le me -- us, quid fe -- ci ti -- bi?  
Aut in quo con -- tri -- stá -- vi te?
Res -- pón -- de mi -- hi.
\once \override LyricText.self-alignment-X = #LEFT
"Quia eduxi te de terra Æ"\breve -- gýp -- ti
\once \override LyricText.self-alignment-X = #LEFT
"parásti Crucem" Sal -- va -- tó -- ri tu -- o.
"(A" -- gi -- "os ...)"
\once \override LyricText.self-alignment-X = #LEFT
"Quia edúxi te per desértum quadragínta" an -- nis,
\once \override LyricText.self-alignment-X = #LEFT
"et manna cibávi" te,
\once \override LyricText.self-alignment-X = #LEFT
"et introdúxi in terram satis" óp -- ti -- "mam :"
\once \override LyricText.self-alignment-X = #LEFT
"parásti Crucem" Sal -- va -- tó -- ri tu -- o.
}

rehearsalMidi = #
(define-music-function
 (parser location name midiInstrument lyrics) (string? string? ly:music?)
 #{
   \unfoldRepeats <<
     \new Staff = "soprano" \new Voice = "soprano" { \soprano }
     \new Staff = "alto" \new Voice = "alto" { \alto }
     \new Staff = "tenor" \new Voice = "tenor" { \tenor }
     \new Staff = "bass" \new Voice = "bass" { \bass }
     \context Staff = $name {
       \set Score.midiMinimumVolume = #0.5
       \set Score.midiMaximumVolume = #0.5
       \set Score.tempoWholesPerMinute = #(ly:make-moment 100 4)
       \set Staff.midiMinimumVolume = #0.8
       \set Staff.midiMaximumVolume = #1.0
       \set Staff.midiInstrument = $midiInstrument
     }
     \new Lyrics \with {
       alignBelowContext = $name
     } \lyricsto $name $lyrics
   >>
 #})

\score {
  \new ChoirStaff <<
    \new Staff \with {
      midiInstrument = "choir aahs"
      instrumentName = \markup \center-column { "Soprano" "Alto" }
    } <<
      \new Voice = "soprano" { \voiceOne \soprano }
      \new Voice = "alto" { \voiceTwo \alto }
    >>
    \new Lyrics \with {
      \override VerticalAxisGroup #'staff-affinity = #CENTER
    } \lyricsto "soprano" \verse
    \new Staff \with {
      midiInstrument = "choir aahs"
      instrumentName = \markup \center-column { "Ténor" "Basse" }
    } <<
      \clef bass
      \new Voice = "tenor" { \voiceOne \tenor }
      \new Voice = "bass" { \voiceTwo \bass }
    >>
  >>
  \layout { }
  \midi {
    \tempo 4=100
  }
}

% Fichiers MIDI pour répétitions :
\book {
  \bookOutputSuffix "soprano"
  \score {
    \rehearsalMidi "soprano" "soprano sax" \verse
    \midi { }
  }
}

\book {
  \bookOutputSuffix "alto"
  \score {
    \rehearsalMidi "alto" "soprano sax" \verse
    \midi { }
  }
}

\book {
  \bookOutputSuffix "tenor"
  \score {
    \rehearsalMidi "tenor" "tenor sax" \verse
    \midi { }
  }
}

\book {
  \bookOutputSuffix "bass"
  \score {
    \rehearsalMidi "bass" "tenor sax" \verse
    \midi { }
  }
}

